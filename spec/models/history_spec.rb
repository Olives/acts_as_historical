require File.dirname(__FILE__) + '/../spec_helper'

describe History do

  before(:each) do
    Thread.current[:actual_user] = FactoryGirl.create(:user)
  end

  after :each do
    Thread.current[:actual_user]= nil
  end

  describe "#record_changes" do

    context "when a model is saved" do

      it "should save history on all the fields" do
        f = FactoryGirl.create(:watched_model)
        h = History.first
        h.item_type.should eq(f.class.to_s)
        h.historical.should eq f
        h.before.should be_empty
        f.attributes.each do |id, value|
          next if id == "id"
          h.after[id.intern].should eq(value)
        end
      end

      it "should save updated fields" do
        f = FactoryGirl.create(:watched_model)
        old_attributes = f.attributes
        f.update_attributes(:name => "Second Name")
        h = f.histories.last
        h.historical.should eq f
        f.attributes.each do |id, value|
          next if id == "id"
          h.before[id.intern].should eq old_attributes[id]
          h.after[id.intern].should eq(value)
        end
      end

      it "should not save anything if no fields were no updated fields" do
        f = FactoryGirl.create(:watched_model)
        old_attributes = f.attributes
        f.save
        h = f.histories.length.should eq 1
      end

    end

    context "when a dependent model is created" do

      it "should save dependent model details on the parent" do
        w = FactoryGirl.create(:watched_model)
        s = FactoryGirl.create(:second_watched_model)
        d = FactoryGirl.create(:dependent_model, :watched_model => w, :second_watched_model => s)
        old_attributes = d.attributes
        d.update_attributes(:status => "accepted", :name => "new name")
        [w, s].each do |parent|
          h = parent.histories.last
          h.item_type.should eq(d.class.to_s)
          h.historical.should eq parent
          d.attributes.each do |id, value|
            next if id == "id"
            h.before[id.intern].should eq old_attributes[id]
            h.after[id.intern].should eq(value)
          end
        end
      end

      it "should save the added associations" do
        w = FactoryGirl.create(:watched_model)
        s = FactoryGirl.create(:second_watched_model)
        d = FactoryGirl.create(:dependent_model, :watched_model => w, :second_watched_model => s)
        [w, s].each do |parent|
          h = parent.histories.last
          h.item_type.should eq(d.class.to_s)
          h.historical.should eq parent
          h.before.should be_empty
          d.attributes.each do |id, value|
            next if id == "id"
            h.after[id.intern].should eq(value)
          end
        end
      end

      it "should save the removed associations when dependent is destroy" do
        w = FactoryGirl.create(:watched_model)
        s = FactoryGirl.create(:second_watched_model)
        d = FactoryGirl.create(:dependent_model, :watched_model => w, :second_watched_model => s)
        d.destroy
        [w, s].each do |parent|
          h = parent.histories.last
          h.item_type.should eq(d.class.to_s)
          h.historical.should eq parent
          h.after.should be_empty
          d.attributes.each do |id, value|
            next if id == "id"
            h.before[id.intern].should eq value
          end
        end
      end

      it "should add/remove associations dependent's foreign key is changed" do
        w1 = FactoryGirl.create(:watched_model)
        w2 = FactoryGirl.create(:watched_model)
        s1 = FactoryGirl.create(:second_watched_model)
        s2 = FactoryGirl.create(:second_watched_model)
        d = FactoryGirl.create(:dependent_model, :watched_model => w1, :second_watched_model => s1)
        old_attributes = d.attributes
        d.update_attributes(:watched_model => w2)
        h = w1.histories.last
        h.item_type.should eq(d.class.to_s)
        h.after.should be_empty
        old_attributes.each do |id, value|
          next if id == "id"
          h.before[id.intern].should eq value
        end
        h = w2.histories.last
        h.item_type.should eq(d.class.to_s)
        h.before.should be_empty
        d.attributes.each do |id, value|
          next if id == "id"
          h.after[id.intern].should eq value
        end

        old_attributes = d.attributes
        d.update_attributes(:second_watched_model => s2)
        h = s1.histories.last
        h.item_type.should eq(d.class.to_s)
        h.after.should be_empty
        old_attributes.each do |id, value|
          next if id == "id"
          h.before[id.intern].should eq value
        end
        h = s2.histories.last
        h.item_type.should eq(d.class.to_s)
        h.before.should be_empty
        d.attributes.each do |id, value|
          next if id == "id"
          h.after[id.intern].should eq value
        end
      end

    end

  end

end
