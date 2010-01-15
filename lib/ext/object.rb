class Object
  def inspect_id
    sprintf "0x%07x", object_id * 2
  end
end

class Symbol
  def to_proc
    Proc.new {|e| e.send self}
  end
end
