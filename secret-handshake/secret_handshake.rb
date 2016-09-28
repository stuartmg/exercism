class SecretHandshake

  CMDS = {
    "wink" => 1,
    "double blink" => 2,
    "close your eyes" => 4,
    "jump" => 8
  }

  REVERSE_ORDER = 16

  attr_accessor :commands

  def initialize(input)
    num = input.to_i

    @commands = []

    CMDS.each_pair do |cmd, mask|
      commands << cmd if mask & num == mask
    end

    commands.reverse! if REVERSE_ORDER & num == REVERSE_ORDER
  end

end