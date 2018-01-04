describe Ws::SFTP::Configuration do
  let(:host) { 'sftp.wealthsimple.com' }
  let(:username) { 'foo' }
  let(:password) { 'bar' }

  describe '#configure' do
    it 'sets global config' do
      Ws::SFTP.reset_configuration!
      expect(Ws::SFTP.configuration.host).to be_nil

      Ws::SFTP.configure do |config|
        config.host = host
        config.username = username
        config.password = password
      end

      expect(Ws::SFTP.configuration.host).to eq(host)
      expect(Ws::SFTP.configuration.username).to eq(username)
      expect(Ws::SFTP.configuration.password).to eq(password)
    end
  end
end
