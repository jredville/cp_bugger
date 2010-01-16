class Symbol
  def to_proc
    Proc.new {|e| e.send self}
  end

  def to_ivar
    :"@#{to_s}"
  end
end
