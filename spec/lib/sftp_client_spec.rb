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

    it "will list contents of a directory" do
      allow(dir).to receive(:foreach).and_yield(filename1).and_yield(filename2)

      expect(subject.ls.count).to eq(2)
      expect(subject.ls).to eq([filename1.name, "#{filename2.name}/"])
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
end
