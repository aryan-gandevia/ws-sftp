describe Ws::SFTP::Client do
  let(:dir) { double }
  let(:file) { double }
  let(:session) { double(Net::SFTP::Session, dir: dir, file: file) }

  before do
    allow(Net::SFTP).to receive(:start).and_yield(session)
  end

  describe '#ls' do
    let(:filename1) { double(Net::SFTP::Protocol::V01::Name, 'name' => 'file1.csv', 'directory?' => false) }
    let(:filename2) { double(Net::SFTP::Protocol::V01::Name, 'name' => 'dir1', 'directory?' => true) }

    before do
      allow(dir).to receive(:foreach).and_yield(filename1).and_yield(filename2)
    end

    it "will list contents of a directory" do
      expect(subject.ls.count).to eq(2)
      expect(subject.ls).to eq([filename1.name, "#{filename2.name}/"])
    end

    context 'with additional options' do
      subject do
        described_class.new(
          host: 'host-123',
          username: 'user-123',
          password: 'pass-123',
          options: {
            keys: ['/path/to/private-key.pem'],
            keepalive: true,
          },
        )
      end

      it "calls start_session with correct options" do
        subject.ls
        expect(Net::SFTP).to have_received(:start).with('host-123', 'user-123', {
          password: 'pass-123',
          non_interactive: true,
          keys: ['/path/to/private-key.pem'],
          keepalive: true,
        })
      end

      it "will list contents of a directory" do
        expect(subject.ls.count).to eq(2)
        expect(subject.ls).to eq([filename1.name, "#{filename2.name}/"])
      end
    end
  end

  describe '#each_file' do
    let(:test_file) { double('File', read: 'test file contents') }

    it "will iterate over every path" do
      allow(file).to receive(:open).and_yield(test_file)

      files = []
      subject.each_file(['/test', '/test2']) { |_, content| files << content }

      expect(files.count).to eq(2)
      expect(files.first).to eq(test_file.read)
    end
  end

  describe '#write' do
    subject { described_class.new }

    let(:test_file) { double('File', write: true) }
    let(:test_content) { 'test file contents' }

    it 'will write a file to the remote server' do
      allow(file).to receive(:open).and_yield(test_file)

      expect(subject.write('/test', test_content)).to be_truthy
    end

    context 'contents are a StringIO' do
      let(:test_content) { StringIO.new('test file contents') }

      it 'will write a file to the remote server' do
        allow(file).to receive(:open).and_yield(test_file)

        expect(subject.write('/test', test_content)).to be_truthy
      end
    end
  end
end
