-- 1. Roles Table for scalable user permissions
CREATE TABLE roles (
    role_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    role_name VARCHAR(50) UNIQUE NOT NULL,  -- e.g., 'renter', 'landlord', 'investor'
    description TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 2. Users Table (now referencing roles)
CREATE TABLE users (
    user_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    date_of_birth DATE NOT NULL,
    role_id UUID REFERENCES roles(role_id),
    profile_picture TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 3. User Preferences
CREATE TABLE user_preferences (
    preference_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    preferred_property_types TEXT[], -- e.g., ['apartment', 'house']
    preferred_locations TEXT[],        -- e.g., ['Toronto', 'New York']
    monthly_budget_min DECIMAL(10,2),
    monthly_budget_max DECIMAL(10,2),
    amenities TEXT[],                  -- e.g., ['gym', 'parking']
    community_features TEXT[],         -- e.g., ['quiet neighborhood']
    furnishing_preference VARCHAR(50) CHECK (furnishing_preference IN ('furnished', 'unfurnished')),
    moving_timeline VARCHAR(50) CHECK (moving_timeline IN ('immediate', 'within 1 month', 'within 3 months')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 4. Properties Table with basic property details
CREATE TABLE properties (
    property_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(12,2) NOT NULL,
    location TEXT NOT NULL,
    property_type VARCHAR(50) CHECK (property_type IN ('apartment', 'house', 'studio', 'condo', 'duplex', 'townhouse')),
    square_feet INT,
    bedrooms INT,
    bathrooms INT,
    roi DECIMAL(5,2), -- Return on Investment %
    status VARCHAR(50) CHECK (status IN ('available', 'funded', 'exited')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 5. Property Amenities
CREATE TABLE property_amenities (
    amenity_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    amenity_name VARCHAR(255) NOT NULL
);

-- 6. User-Property Relationship Table (roles per property)
CREATE TABLE user_properties (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    role VARCHAR(50) CHECK (role IN ('owner', 'renter', 'investor')),
    status VARCHAR(50) CHECK (status IN ('active', 'pending', 'terminated')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 7. Investments Table
CREATE TABLE investments (
    investment_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    investment_amount DECIMAL(12,2) NOT NULL,
    ownership_percentage DECIMAL(5,2) CHECK (ownership_percentage >= 0 AND ownership_percentage <= 100),
    roi DECIMAL(5,2),
    total_return_5yr DECIMAL(12,2),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 8. Portfolio (current snapshot) and Portfolio History
CREATE TABLE portfolio (
    portfolio_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    total_investments DECIMAL(12,2),
    monthly_income DECIMAL(12,2),
    annual_roi DECIMAL(5,2),
    balance DECIMAL(12,2),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE portfolio_history (
    history_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    portfolio_id UUID REFERENCES portfolio(portfolio_id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    total_investments DECIMAL(12,2),
    monthly_income DECIMAL(12,2),
    annual_roi DECIMAL(5,2),
    balance DECIMAL(12,2),
    snapshot_date TIMESTAMP DEFAULT NOW()
);

-- 9. Transactions Table (with parent_transaction_id for linking refunds/payments)
CREATE TABLE transactions (
    transaction_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    transaction_type VARCHAR(50) CHECK (transaction_type IN ('rent_payment', 'investment_purchase', 'payout')),
    amount DECIMAL(12,2) NOT NULL,
    payment_method VARCHAR(50) CHECK (payment_method IN ('wallet', 'bank_transfer', 'credit_card')),
    status VARCHAR(50) CHECK (status IN ('pending', 'completed', 'failed')),
    parent_transaction_id UUID REFERENCES transactions(transaction_id) ON DELETE SET NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 10. Search Filters Table
CREATE TABLE search_filters (
    filter_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_type TEXT[], -- e.g., ['apartment', 'studio']
    min_price DECIMAL(12,2),
    max_price DECIMAL(12,2),
    location TEXT,
    bedrooms INT,
    bathrooms INT,
    amenities TEXT[],
    created_at TIMESTAMP DEFAULT NOW()
);

-- 11. Chat Rooms for direct user communication
CREATE TABLE chat_rooms (
    chat_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    landlord_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    tenant_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 12. Messages Table (with is_read flag)
CREATE TABLE messages (
    message_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    chat_id UUID REFERENCES chat_rooms(chat_id) ON DELETE CASCADE,
    sender_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT NOW()
);

-- 13. Notifications Table (with a type classification)
CREATE TABLE notifications (
    notification_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    type VARCHAR(50), -- e.g., 'system', 'rent_due', 'new_property'
    message TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 14. User Settings Table
CREATE TABLE user_settings (
    setting_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    notification_preferences JSONB DEFAULT '{}',
    privacy_settings JSONB DEFAULT '{}',
    referral_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 15. Saved Properties Table (standardized to UUID)
CREATE TABLE saved_properties (
    saved_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 16. Reviews Table (using UUID for consistency)
CREATE TABLE reviews (
    review_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    rating DECIMAL(2,1) CHECK (rating BETWEEN 1.0 AND 5.0),
    review_text TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 17. Property Images Table
CREATE TABLE property_images (
    image_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- 18. Property Visits Table
CREATE TABLE property_visits (
    visit_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    property_id UUID REFERENCES properties(property_id) ON DELETE CASCADE,
    scheduled_date TIMESTAMP NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Scheduled', 'Completed', 'Canceled')),
    created_at TIMESTAMP DEFAULT NOW()
);

-- 19. User Sessions Table for authentication management
CREATE TABLE user_sessions (
    session_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE CASCADE,
    session_token TEXT NOT NULL,
    ip_address TEXT,
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    expires_at TIMESTAMP
);

-- 20. Event Logs Table for tracking critical user actions and auditing
CREATE TABLE event_logs (
    log_id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(user_id) ON DELETE SET NULL,
    event_type VARCHAR(100),
    description TEXT,
    event_timestamp TIMESTAMP DEFAULT NOW()
);

-- 21. Improved Indexes for optimized querying
CREATE INDEX idx_transactions_user_status ON transactions(user_id, status);
CREATE INDEX idx_properties_location ON properties(location);
CREATE INDEX idx_properties_price ON properties(price);
CREATE INDEX idx_properties_property_type ON properties(property_type);
CREATE INDEX idx_properties_roi ON properties(roi);
