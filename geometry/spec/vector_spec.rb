__DIR__ = File.dirname(__FILE__)
require File.join(__DIR__, 'spec_helper')

describe Vector do
  describe "Vector()" do
    context "when called with two numbers" do
      before :each do
        @vector = Vector(1, 3)
      end

      it "should create a vector with given coordinates" do
        @vector.should be_a(Vector)
        @vector.x.should == 1
        @vector.y.should == 3
      end
    end
  end

  describe ".polar" do
    context "when called with two numbers" do      
      subject { Vector.polar(1, 30.degrees) }

      it "should create a vector with given modulus and angle" do
        subject.should be_a(Vector)
        subject.modulus.should === 1
        subject.angle.should === 30.degrees
        subject.should === Vector(Math.sqrt(3) / 2, 0.5)
      end
    end
  end

  describe "#signed_angle_with" do
    context "when angle is less than Pi" do
      before :each do
        @vector = Vector(1, 0)
        @another_vector = Vector(0, 1)
      end

      it "should return angle" do
        @vector.signed_angle_with(@another_vector).should === 90.degrees
      end
    end

    context "when CCW-angle is greater than Pi" do
      before :each do
        @vector = Vector(1, 1)
        @another_vector = Vector(1, -1)
      end

      it "should return negative angle" do
        @vector.signed_angle_with(@another_vector).should === -90.degrees
      end
    end

    context "when angle is equal to Pi" do
      before do
        @vector = Vector(1, 0)
        @another_vector = Vector(-1, 0)        
      end

      it "should return Pi" do
        @vector.signed_angle_with(@another_vector).should === 180.degrees
      end
    end

    context "when angle is zero" do
      before do
        @vector = Vector(1, 0)
        @another_vector = Vector(1, 0)
      end

      it "should return zero" do
        @vector.signed_angle_with(@another_vector).should === 0.degrees
      end
    end
  end

  describe "#angle_with" do
    context "when angle is less than Pi" do
      before :each do
        @vector = Vector(1, 0)
        @another_vector = Vector(0, 1)
      end

      it "should return angle" do
        @vector.angle_with(@another_vector).should === 90.degrees
      end
    end

    context "when CCW-angle is greater than Pi" do
      before :each do
        @vector = Vector(1, 1)
        @another_vector = Vector(1, -1)
      end

      it "should still return smallest positive angle" do
        @vector.angle_with(@another_vector).should === 90.degrees
      end
    end

    context "when angle is Pi" do
      before do
        @vector = Vector(1, 0)
        @another_vector = Vector(-1, 0)
      end

      it "should return Pi" do
        @vector.angle_with(@another_vector).should === 180.degrees
      end
    end
  end

  describe "#angle" do
    context "when endpoint is upper than X-axis" do
      it "should return positive angle" do
        Vector(1, 1).angle.should === 45.degrees
        Vector(0, 1).angle.should === 90.degrees
        Vector(-1, 1).angle.should === 135.degrees
      end
    end

    context "when endpoint is on X-axis" do
      context "when endpoint is on the right from origin" do
        it "should return zero" do
          Vector(1, 0).angle.should === 0
        end
      end

      context "whem endpoint is on the left from origin" do
        it "should return Pi" do
          Vector(-1, 0).angle.should == 180.degrees
        end
      end
    end
  end
end
