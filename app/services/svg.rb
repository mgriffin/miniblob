class Svg
  WIDTH = 200
  HEIGHT = 200
  CENTRE_X = WIDTH / 2
  CENTRE_Y = HEIGHT / 2

  def initialize
    set_colours
  end

  def svg
    <<~SVG
      <svg xmlns="http://www.w3.org/2000/svg" class="canvas" viewBox="0 0 #{HEIGHT} #{WIDTH}" style="background: #{@light_colour}">
      #{draw_body}
      #{draw_eyes}
      </svg>
    SVG
  end

  def draw_body
    number_of_points = rand(3..12)
    size = rand(50..80)
    anglestep = (Math::PI * 2) / number_of_points
    points = []

    number_of_points.times do |i|
      pull = rand(0.75..1.0)
      # 100 is half the size of the viewbox, which places the
      # character in the centre of the view
      x = CENTRE_X + Math.cos(i * anglestep) * (size * pull)
      y = CENTRE_Y + Math.sin(i * anglestep) * (size * pull)

      points << {x: x.to_i, y: y.to_i}
    end

    d = spline(points)
    <<~PATH
      <path d="#{d}" stroke="#{@dark_colour}" stroke-width="2" fill="#{@primary_colour}" />
    PATH
  end

  def eye(x, y, size)
    <<~EYE
      <circle cx="#{x}" cy="#{y}" r="#{size}" stroke="#{@dark_colour}" stroke-width="2" fill="#{@light_colour}" />
      <circle cx="#{x}" cy="#{y}" r="#{size / 2}" fill="#{@dark_colour}" />
    EYE
  end

  def draw_eyes
    max_eye_size = 25
    eye_size = rand((max_eye_size / 2)..max_eye_size)
    cyclops = (rand > 0.75)

    eyes = ""
    if cyclops
      eyes = eye(CENTRE_X, CENTRE_Y, eye_size)
    else
      eyes = eye(CENTRE_X - max_eye_size, CENTRE_X, eye_size)
      eyes += eye(CENTRE_Y + max_eye_size, CENTRE_Y, eye_size)
    end
    eyes
  end

  def spline(points)
    # move to the starting position
    path = "M" + points.first.values.join(",")

    # add the first two points to the end of the array so that the calculation
    # is made a little easier
    extended = points + points.first(2)

    extended.each_with_index do |p, i|
      # don't calculate last two points because we added them on earlier
      break if (i + 2) == extended.size

      # get the previous point
      # if this is the first point then we have to get the last one
      # from the original points array
      x0 = i == 0 ? points.last[:x] : extended[i - 1][:x]
      y0 = i == 0 ? points.last[:y] : extended[i - 1][:y]

      # this is the current point
      x1 = p[:x]
      y1 = p[:y]

      # this is the next point
      x2 = extended[i + 1][:x]
      y2 = extended[i + 1][:y]

      # this is a point two in the future and is the reason we added the first
      # two points to the end of the array earlier
      x3 = i == (extended.size - 1) ? extended.first[:x] : extended[i + 2][:x]
      y3 = i == (extended.size - 1) ? extended.first[:y] : extended[i + 2][:y]

      # calculate the control points
      cp1x = x1 + ((x2 - x0) / 6)
      cp1y = y1 + ((y2 - y0) / 6)

      cp2x = x2 - ((x3 - x1) / 6)
      cp2y = y2 - ((y3 - y1) / 6)

      path += " C" + [cp1x, cp1y, cp2x, cp2y, x2, y2].join(",")
    end

    path
  end

  def set_colours
    hue = rand(0..360)
    saturation = rand(75..100)
    lightness = rand(75..95)

    @primary_colour = "hsl(#{hue}, #{saturation}%, #{lightness}%)"
    @dark_colour = "hsl(#{hue}, #{saturation}%, 2%)"
    @light_colour = "hsl(#{hue}, #{saturation}%, 98%)"
  end
end
