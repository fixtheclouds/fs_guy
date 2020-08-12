require 'spec_helper'

RSpec.describe FsGuy::Engine do
  describe '#folder' do
    subject { described_class.new.folder(name) }

    let(:name) { 'test' }

    it 'creates a folder' do
      FakeFS.with_fresh do
        subject
        expect(File.directory?(name)).to eq true
      end
    end

    context 'with block' do
      subject { described_class.new.folder(name, &block) }

      let(:block) { proc {} }

      it 'evaluates block' do
        expect_any_instance_of(described_class).to receive(:instance_eval).once

        subject
      end
    end
  end
end
