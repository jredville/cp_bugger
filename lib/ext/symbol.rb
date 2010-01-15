class Symbol
  def to_proc
    Proc.new {|e| e.send self}
  end
end
