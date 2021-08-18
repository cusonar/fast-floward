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

pub resource Picture {
    pub let canvas: Canvas
    init(canvas: Canvas) {
        self.canvas = canvas
    }
}

pub resource Printer {
    init() {

    }
    pub fun print(canvas: Canvas): @Picture? {
      display(canvas: canvas)
      return <- create Picture(canvas: canvas)
    }
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
  let printer <- create Printer()
  let picture <- printer.print(canvas: canvasX)
  destroy picture
  destroy printer
}