require 'spec_helper'

RSpec.describe FsGuy do
  describe '#run' do
    subject { described_class.run }

    it 'fails without block' do
      expect { subject }.to raise_error(FsGuy::Error)
    end

    context 'when block given' do
      subject { described_class.run(&instructions) }

      let(:instructions) { proc { file 'file.txt' } }

      it 'succeeeds' do
        expect { subject }.not_to raise_error
      end
    end
  end
end
