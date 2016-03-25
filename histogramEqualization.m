function imageOut = histogramEqualization(orgImage)
    imageOut = histeq(uint8(orgImage));
end