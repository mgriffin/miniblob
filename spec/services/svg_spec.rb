require "nokogiri"
require_relative "../../app/services/svg"

describe Svg do
  it "returns an SVG file" do
    svg = Nokogiri::XML(Svg.new.svg)
    viewbox = svg.xpath(".//svg").attr("viewBox").value
    expect(viewbox).to eq("0 0 200 200")
  end

  it "has a path in the SVG file" do
    svg = Nokogiri::XML(Svg.new.svg)
    path = svg.at_xpath("//path")

    expect(path).not_to be_nil
  end

  context "spline" do
    let(:points) { [{x: 10, y: 90}, {x: 50, y: 10}, {x: 90, y: 90}, {x: 40, y: 120}] }

    it "returns the proper path" do
      expect(Svg.new.spline(points)).to eq("M10,90 C11,71,37,10,50,10 C63,10,92,72,90,90 C88,108,54,120,40,120 C26,120,9,109,10,90")
    end
  end

  context "eye" do
    it "returns an eye" do
      eye = Svg.new.eye(0, 0, 20)

      expect(Nokogiri::HTML(eye).xpath("//circle").length).to eq(2)
    end
  end
end
