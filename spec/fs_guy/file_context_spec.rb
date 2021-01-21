require 'pp'
require 'spec_helper'

RSpec.describe FsGuy::FileContext do
  let(:file_context) { described_class.new(path) }
  let(:path) { 'file.txt' }

  describe '#move' do
    subject { file_context.move }

    it 'sets operation' do
      FakeFS.with_fresh do
        expect { subject }
          .to change { file_context.instance_variable_get(:@operation) }
          .to :move
      end
    end
  end

  describe '#copy' do
    subject { file_context.copy }

    it 'sets operation' do
      FakeFS.with_fresh do
        expect { subject }
          .to change { file_context.instance_variable_get(:@operation) }
          .to :copy
      end
    end
  end

  describe 'to' do
    subject { file_context.to(new_path) }

    let(:new_path) { 'new.txt' }

    context 'without path' do
      let(:file_context) { described_class.new(nil) }

      it 'fails' do
        FakeFS.with_fresh do
          expect { subject }.to raise_error FsGuy::Error
        end
      end
    end

    context 'without operation' do
      it 'fails' do
        FakeFS.with_fresh do
          expect { subject }.to raise_error FsGuy::Error
        end
      end
    end
  end
end
