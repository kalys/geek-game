require "spec_helper"
require "active_support/core_ext/hash/keys"

describe Network::Client do
  let(:objects_hash) do
    {
      "game_objects" => [
                         {
                           "id" => 2154658800,
                           "type" => "factory",
                           "position" => [-800, -400],
                           "angle" => 0.7853981633974483
                         },
                         {
                           "id" => 2154658600,
                           "type" => "recharger",
                           "position" => [-800, -400],
                           "angle" => nil
                         },
                         {
                           "id" => 2168504880,
                           "type" => "tracked_bot",
                           "position" => [-28.894112991630443, -77.27638497287744],
                           "angle" => -6.424728038547264
                         }
                        ]
    }
  end

  describe "#next_data_chunk" do
    let(:serialized_data) { BSON.serialize(objects_hash).to_s }

    let(:socket) { SocketStub.new(serialized_data * 2) }

    subject { Network::Client.new(socket) }

    it "should get and parse data correctly" do
      2.times { subject.next_data_chunk.should == objects_hash }
    end
  end

  describe "#current_world_state" do
    subject { Network::Client.new(nil) }

    before { subject.stub :next_data_chunk => objects_hash }

    it "should compose a convenient objects hash" do
      subject.current_world_state.should == {
        2154658800 => {
          :type => "factory",
          :position => [-800, -400],
          :angle => 0.7853981633974483
        },
        2154658600 => {
          :type => "recharger",
          :position => [-800, -400],
          :angle => nil
        },
        2168504880 => {
          :type => "tracked_bot",
          :position => [-28.894112991630443, -77.27638497287744],
          :angle => -6.424728038547264
        }
      }
    end
  end
end
