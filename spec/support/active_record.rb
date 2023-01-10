ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'granite',
  username: 'granite',
  password: 'granite',
  host: 'localhost'
)
ActiveRecord::Base.logger = Logger.new('/dev/null')

ActiveRecord::Schema.define do
  create_table :users, force: :cascade do |t|
    t.column :email, :string
    t.column :projects, :text
    t.column :profile, :text
  end

  create_table :authors, force: :cascade do |t|
    t.column :name, :string
    t.column :status, :integer
    t.column :related_ids, :integer, array: true
    t.column :data, :text
  end
end
