pub struct Canvas {
  pub let width: UInt8;
  pub let height: UInt8;
  pub let pixels: String;

  init(width: UInt8, height: UInt8, pixels: String) {
    self.width = width;
    self.height = height;
    self.pixels = pixels;
  }
}

pub fun serializeStringArray(_ lines: [String]): String {
  var buffer = ""
  for line in lines {
    buffer = buffer.concat(line)
  }
  return buffer;
}

pub fun unserializeString(line: String, width: UInt8): [String] {
  let lines: [String] = [];
  var from = 0

  while from < line.length {
    let row = line.slice(from: from, upTo: from + Int(width))
    lines.append(row);
    from = from + Int(width)
  }
  return lines;
}

pub fun display(canvas: Canvas){
  var topAndBottom = "+"
  var index = 0 
  while index < Int(canvas.width) {
      topAndBottom = topAndBottom.concat("-")
      index = index + 1
  }
  topAndBottom = topAndBottom.concat("+")
  let side = "|"

  let pixelsArray = unserializeString(line: canvas.pixels, width: canvas.width )

  log(topAndBottom)
  for line in pixelsArray {
    log(side.concat(line).concat(side))
  }
  log(topAndBottom)
}


pub fun main() {
  let pixelsX = [
    "*   *",
    " * * ",
    "  *  ",
    " * * ",
    "*   *"
  ]
  let canvasX = Canvas(width: 5, height: 5, pixels: serializeStringArray(pixelsX))
  display(canvas: canvasX)
}