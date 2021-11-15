using Luxor

# blatantly stolen/adapted from https://juliagraphics.github.io/Luxor.jl/stable/tutorial/quickstart/#Taking-particles-seriously
function drawcircle(pos, radius, c)
    for i in 5:-0.1:1
        setcolor(rescale(i, 5, 1, 0.5, 3) .* c)
        circle(pos + (i/2, i/2), rescale(i, 5, 1, radius, radius/6), :fill)
    end
end

green = Luxor.julia_green
red = Luxor.julia_red
purple = Luxor.julia_purple
blue = Luxor.julia_blue
colors = [green, red, purple, blue]

function BF3_ish(filename)
    Drawing(500, 500, filename)
    origin()
    setcolor(0.2, 0.2, 0.3)
    squircle(O, 240, 240, rt=0.5, :fill)
    points = O.+[Point(0,-150), Point(-150*sin(pi/3), 75), Point(150*sin(pi/3), 75)]
    
    setline(13)
    for i=1:3
        setcolor(0,0,0)
        line(O, points[i], :stroke)
        drawcircle(points[i], 60, colors[i])
    end
    drawcircle(O, 50, colors[4])
    finish()
    preview()
end

function H2O_ish(filename)
    Drawing(500, 500, filename)
    origin()
    setcolor(0.2, 0.2, 0.3)
    squircle(O, 240, 240, rt=0.5, :fill)
    ang = pi*104.4/360
    offset = Point(0,-50)
    points = offset .+ 180 .*[Point(sin(ang), cos(ang)), Point(sin(-ang), cos(ang))]
    setline(13)
    for point in points
        setcolor(green)
        line(O+offset, point, :stroke)
        #drawcircle(point, 50, colors[2])
        setcolor(red)
        circle(point, 50, :fill)
    end
    #drawcircle(O+offset, 75, colors[3])
    setcolor(purple)
    circle(O+offset, 75, :fill)
    setcolor(blue)
    setline(6)
    arc(O+offset, 100, pi/2-0.8*ang, pi/2+0.8*ang, :stroke)
    finish()
    preview()
end

function RW_water(filename)
    Drawing(500, 500, filename)
    origin()

    # Background
    setcolor(0.2, 0.2, 0.3)
    squircle(O, 240, 240, rt=0.5, :fill)

    # Some hot math
    ang = pi*104.4/360
    offset = Point(0,-50)
    points = offset .+ 180 .*[Point(sin(ang), cos(ang)), Point(sin(-ang), cos(ang))]
    Hcolor = [purple, green]
    setline(13)

    # Draw hydrogens
    for i in eachindex(points)
        point = points[i]
        c = Hcolor[i]

        # Bond
        setcolor(blue)
        setdash("dashed")
        line(O+offset, point, :stroke)

        # Interior H atom
        setcolor(185/255, 183/255, 189/255)
        circle(point, 45, :fill)

        # Exterior H atom
        setcolor(c)
        setdash("solid")
        circle(point, 45, :stroke)
    end

    # Draw oxygen
    setcolor(red)
    Oposition = O+offset
    circle(Oposition, 90, :fill)

    # Call it a day
    finish()
    preview()
end

BF3_ish("bf3_logo.png")
H2O_ish("h2o_logo.png")
RW_water("rw_logo.png")
