class CreateFlightBookingSystem < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :full_name, null: false
      t.string :email, null: false, index: { unique: true, name: 'index_users_on_email' }
      t.string :phone_number
      t.string :password_digest
      t.timestamps
    end

    create_table :companies do |t|
      t.string :business_registration_no, null: false
      t.string :profile_name, null: false
      t.string :country, null: false
      t.text :address, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.string :website
      t.string :tax_identification_number
      t.string :bank_account_number, null: false
      t.references :bank, foreign_key: true, null: false
      t.integer :status, default: 0, null: false  # 0: pending, 1: approved, 2: rejected
      t.timestamps
    end

    create_table :banks do |t|
      t.string :name, null: false
      t.string :swift_code, null: false
      t.string :country, null: false
      t.string :branch_address
      t.timestamps
    end

    create_table :airports do |t|
      t.string :iata_code, null: false
      t.string :icao_code, null: false
      t.string :name, null: false
      t.string :city, null: false
      t.string :country, null: false
      t.timestamps
    end

    create_table :aircrafts do |t|
      t.references :company, foreign_key: true, null: false
      t.string :model, null: false
      t.string :registration_number, null: false
      t.integer :capacity, null: false
      t.timestamps
    end

    create_table :seats do |t|
      t.references :aircraft, foreign_key: true, null: false
      t.string :seat_number, null: false  # e.g., '12A'
      t.integer :seat_class, null: false, default: 0  # 0: Economy, 1: Business, 2: First Class
      t.timestamps
    end

    create_table :flights do |t|
      t.references :aircraft, foreign_key: true, null: false
      t.string :flight_number, null: false
      t.references :departure_airport, foreign_key: { to_table: :airports }, null: false
      t.references :arrival_airport, foreign_key: { to_table: :airports }, null: false
      t.datetime :departure_time, null: false
      t.datetime :arrival_time, null: false
      t.decimal :ticket_price, precision: 10, scale: 2, null: false
      t.integer :available_seats
      t.integer :status, default: 0, null: false  # 0: scheduled, 1: delayed, 2: canceled
      t.timestamps
    end

    create_table :bookings do |t|
      t.references :user, foreign_key: true, null: false
      t.references :flight, foreign_key: true, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.integer :status, default: 0, null: false  # 0: pending, 1: confirmed, 2: canceled
      t.timestamps
    end

    create_table :passengers do |t|
      t.references :booking, foreign_key: true, null: false
      t.string :full_name, null: false
      t.string :passport_number, null: false
      t.references :seat, foreign_key: true  # Link to a specific seat
      t.timestamps
    end
  end
end
