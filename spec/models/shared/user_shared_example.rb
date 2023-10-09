shared_examples 'user_shared_example' do
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a username' do
    user.username = nil
    expect(user).to_not be_valid
  end

  it 'is not valid without a email' do
    user.email = nil
    expect(user).to_not be_valid
  end
  it 'is not valid without a password' do
    user.password = nil
    expect(user).to_not be_valid
  end
  it 'is not valid without a confirmation_password' do
    user.password = nil
    user.password_confirmation = nil
    expect(user).to_not be_valid
  end
end
