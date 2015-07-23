class Fixnum
  def to_bottle_number
    klass = Object.const_get("Container#{self}") rescue ContainerNumber
    klass.new(self)
  end

  def pred
    self == 0 ? 99 : self - 1
  end
end

class Bottles
  def song
    verses(99, 0)
  end

  def verses(upper, lower)
    upper.downto(lower).map { |i| verse(i) }.join("\n")
  end

  def verse(number)
    puts "number is #{number}"
    container_number = number.to_bottle_number

    "#{container_number} of beer on the wall, ".capitalize +
      "#{container_number} of beer.\n" +
      "#{container_number.phrase}, " +
      "#{container_number.successor} of beer on the wall.\n"
  end
end

class ContainerNumber
  attr_reader :number

  def initialize(number)
    @number = number
  end

  def to_s
    "#{quantity} #{container}"
  end

  def phrase
    "Take #{pronoun} down and pass it around"
  end

  def pronoun
    "one"
  end

  def container
    "bottles"
  end

  def quantity
    number.to_s
  end

  def successor
    (number - 1).to_bottle_number
  end
end

class Container0 < ContainerNumber
  def phrase
    "Go to the store and buy some more"
  end

  def quantity
    "no more"
  end
end

class Container1 < ContainerNumber
  def pronoun
    "it"
  end

  def container
    "bottle"
  end
end

class Container6 < ContainerNumber
  def quantity
    'one'
  end

  def container
    'six-pack'
  end
end

puts Bottles.new.song
