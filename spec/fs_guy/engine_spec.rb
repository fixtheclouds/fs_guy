require 'spec_helper'

RSpec.describe FsGuy::Engine do
  describe '#dir' do
    subject { described_class.new('.').dir(name) }

    let(:name) { 'test' }

    it 'creates a folder' do
      FakeFS.with_fresh do
        subject
        expect(File.directory?(name)).to eq true
      end
    end

    context 'with block' do
      subject { described_class.new('.').dir(name, &block) }

      let(:block) { proc {} }

      it 'evaluates block' do
        FakeFS.with_fresh do
          expect_any_instance_of(described_class).to receive(:instance_eval).once

          subject
        end
      end
    end

    context 'when dir it outside root' do
      let(:name) { '../lib' }

      it 'raises error' do
        expect { subject }.to raise_error(FsGuy::Error, 'Cannot operate in parent directory')
      end
    end
  end

  describe '#file' do
    subject { described_class.new('.').file(path) }

    let(:path) { 'file.txt' }

    it 'creates a file' do
      FakeFS.with_fresh do
        subject
        expect(File.file?(path)).to eq true
      end
    end

    context 'when path it outside root' do
      let(:path) { '../file.txt' }

      it 'raises error' do
        expect { subject }.to raise_error(FsGuy::Error, 'Cannot operate in parent directory')
      end
    end
  end

  describe '#method_missing' do
    subject { described_class.new('.').move('file.txt') }

    it 'yields control to file context' do
      expect_any_instance_of(FsGuy::FileContext).to receive(:move)

      subject
    end
  end
end
