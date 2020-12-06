class com.PracHack.KoopaShell.Mnemonic
{
    private var str:String;
    
    private var _opcode:String;
    private var _operands:Array;
    
    public function Mnemonic(string)
    {
        this.str = string;
        
        this._opcode = "";
        this._operands = [];
        
        this.parseString(string);
    }
    
    private function parseString(string)
    {
        var mode = 0;
        var strchar:String;
        var curOperand:String = "";
        
        for(var i = 0; i < string.length; i++)
        {
            switch(mode)
            {
                case 0:
                    if(string.charAt(i) == " ")
                    {
                        mode = 1;
                        curOperand = "";
                    }
                    else
                    {
                        this._opcode += string.charAt(i);
                    }
                    break;
                
                case 1:
                    switch(string.charAt(i))
                    {
                        case "\"":
                        case "'":
                            mode = 2;
                            strchar = string.charAt(i);
                            break;
                        
                        case " ":
                            this._operands.push(curOperand);
                            curOperand = "";
                            break;
                    
                        default:
                            curOperand += string.charAt(i);
                    }
                    break;
                
                case 2:
                    switch(string.charAt(i))
                    {
                        case "\"":
                        case "'":
                            if(strchar == string.charAt(i))
                            {
                                mode = 1;
                            }
                            else
                            {
                                curOperand += string.charAt(i);
                            }
                            break;
                        
                        case "\\":
                            i++;
                            curOperand += string.charAt(i);
                            break;
                        
                        default:
                            curOperand += string.charAt(i);
                    }
                    break;
            }
        }
        if(curOperand != "")
        {
            this._operands.push(curOperand);
        }
    }
    
    public function toString()
    {
        return this.str;
    }
    
    public function get opcode()
    {
        return this._opcode;
    }
    
    public function get operands()
    {
        return this._operands;
    }
}