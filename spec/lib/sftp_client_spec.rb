describe Ws::SFTP::Client do
  before(:each) { use_default_configuration! }

  let(:dir) { double }
  let(:file) { double }
  let(:session) { double(Net::SFTP::Session, dir: dir, file: file) }

  before do
    allow(Net::SFTP).to receive(:start).and_yield(session)
  end

  describe '#ls' do
    let(:filename1) { double(Net::SFTP::Protocol::V01::Name, 'name' => 'file1.csv', 'directory?' => false) }
    let(:filename2) { double(Net::SFTP::Protocol::V01::Name, 'name' => 'dir1', 'directory?' => true) }

    it "will list contents of a direcotry" do
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

  describe '#get_final_path' do
    let(:base_path) { '/test' }
    let(:filename) { 'testfile.txt' }
    subject { described_class.new(base_path: base_path) }

    it "will prepend the base_path" do
      allow(dir).to receive(:foreach).and_yield(filename)
      expect(subject).to receive(:ls).and_return("#{base_path}/#{filename}")

      subject.ls
    end
  end
end
