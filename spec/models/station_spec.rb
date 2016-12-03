require_relative "../spec_helper"

describe "Station" do
  describe "Validations" do
    it "Can save if all fields are present" do
      Station.write(name: "TestStation1", lat: 1.1, long: 1.2, dock_count: 1, city_id: 1, installation_date: "2011-11-11")

      expect(Station.find(1).name).to eq("TestStation1")
    end
  end
end