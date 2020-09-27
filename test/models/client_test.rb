require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  test 'unique code' do
    e = clients(:lorem)
    c = Client.new(name: 'new client', phone: '7488444', email: 'client@client.com', code: e.code)
    refute c.save
  end

  test 'name required' do
    c = Client.new(phone: '7488444', email: 'client@client.com')
    refute c.save
    assert_not_nil c.errors[:name]
  end

  test 'phone required' do
    c = Client.new(name: 'new client', email: 'client@client.com')
    refute c.save
    assert_not_nil c.errors[:phone]
  end

  test 'email required' do
    c = Client.new(name: 'new client', phone: '7488444')
    refute c.save
    assert_not_nil c.errors[:email]
  end
end
