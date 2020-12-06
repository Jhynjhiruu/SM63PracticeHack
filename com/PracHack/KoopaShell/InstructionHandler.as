class com.PracHack.KoopaShell.InstructionHandler
{
    
    private var stack;
    
    private var funcs;
    
    private var execMode;
    
    private var defFunc;
    
    public function InstructionHandler()
    {
        this.stack = new Array();
        this.funcs = new Object();
        this.execMode = 0;
        this.defFunc = "";
    }
    
    // instruction functions, yay
    
    public function push(operands)
    {
        var i;
        for(i = 0; i < operands.length; i++)
        {
            this.stack.push(operands[i]);
        }
    }
    
    public function pop(operands)
    {
        if(operands.length == 0 || operands.length == undefined)
        {
            return this.stack.pop();
        }
        
        if(operands.length == 1)
        {
            return this.stack.splice(-Number(operands[0]));
        }
        
        return this.stack.splice(-Number(operands[0]), Number(operands[1]));
        
    }
    
    private function peek(operands)
    {
        if(operands.length == 0 || operands.length == undefined)
        {
            return this.stack.slice(-1);
        }
        
        if(operands.length == 1)
        {
            return this.stack.slice(-Number(operands[0]));
        }
        
        return this.stack.splice(-Number(operands[0]), Number(operands[1]));
        
    }
    
    private function swap(operands)
    {
        var depth;
        
        if(operands.length == 0 || operands.length == undefined)
        {
            depth = 2;
        }
        else
        {
            depth = Number(operands[0]) + 1;
        }
        
        this.push([this.pop([depth, 1])]);
    }
    
    private function dup(operands)
    {
        this.push([this.peek()]);
    }
    
    private function def(operands)
    {
        var funcName;
        
        if(operands.length == 0)
        {
            funcName = this.pop();
        }
        else
        {
            funcName = operands[0];
        }
        
        this.defFunc = funcName;
        
        this.funcs[funcName] = new Array();
        this.execMode = 1;
        
    }
    
    private function lda(operands)
    {
        var loadName;
        
        if(operands.length == 0)
        {
            loadName = this.pop();
        }
        else
        {
            loadName = operands[0];
        }
        this.push([eval(loadName)]);
        
    }
    
    private function sto(operands)
    {
        var storeName;
        
        var storeValue;
        
        if(operands.length == 0)
        {
            storeName = this.pop();
            storeValue = this.pop();
        }
        else if(operands.length == 1)
        {
            storeName = operands[0];
            storeValue = this.pop();
        }
        else
        {
            storeName = operands[0];
            storeValue = operands[1];
        }
        
        set(storeName, storeValue);
        
    }
    
    private function equ(operands)
    {
        var val1;
        var val2;
        
        if(operands.length == 0)
        {
            val1 = this.pop();
            val2 = this.pop();
        }
        else if(operands.length == 1)
        {
            val1 = operands[0];
            val2 = this.pop();
        }
        else
        {
            val1 = operands[0];
            val2 = operands[1];
        }
        
        this.push([val1 == val2]);
        
    }
    
    private function neq(operands)
    {
        this.equ(operands);
        
        this.inv([this.pop()]);
        
    }
    
    private function inv(operands)
    {
        var val;
        
        if(operands.length == 0)
        {
            val = this.pop();
        }
        else
        {
            val = operands[0];
        }
        
        this.push([val == false]);
        
    }
    
    private function ldd(operands)
    {
        this.push(operands);
    }
    
    private function out(operands)
    {
        var outData;
    
        if(operands.length == 0)
        {
            outData = this.peek();
        }
        else
        {
            outData = operands[0];
        }
        
        trace(outData);
        _root.textManager.send('message', outData);
        
    }
    
    private function num(operands)
    {
        var toNum;
        
        if(operands.length == 0)
        {
            toNum = this.pop();
        }
        else
        {
            toNum = operands[0];
        }
        
        this.push([Number(toNum)]);
        
    }
    
    private function str(operands)
    {
        var toStr;
        
        if(operands.length == 0)
        {
            toStr = this.pop();
        }
        else
        {
            toStr = operands[0];
        }
        
        this.push([String(toStr)]);
        
    }
    
    private function bool(operands)
    {
        var toBool;
        
        if(operands.length == 0)
        {
            toBool = this.pop();
        }
        else
        {
            toBool = operands[0];
        }
        
        this.push([Boolean(toBool)]);
        
    }
    
    private function add(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = this.pop();
            num1 = this.pop();
        }
        else if(operands.length == 1)
        {
            num1 = this.pop();
            num2 = operands[0];
        }
        else
        {
            num1 = operands[0];
            num2 = operands[1];
        }
        
        this.push([num1 + num2]);
        
    }
    
    private function sub(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = Number(this.pop());
            num1 = Number(this.pop());
        }
        else if(operands.length == 1)
        {
            num1 = Number(this.pop());
            num2 = Number(operands[0]);
        }
        else
        {
            num1 = Number(operands[0]);
            num2 = Number(operands[1]);
        }
        
        this.push([num1 - num2]);
        
    }
    
    private function mul(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = this.pop();
            num1 = this.pop();
        }
        else if(operands.length == 1)
        {
            num1 = this.pop();
            num2 = operands[0];
        }
        else
        {
            num1 = operands[0];
            num2 = operands[1];
        }
        
        this.push([num1 * num2]);
        
    }
    
    private function div(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = Number(this.pop());
            num1 = Number(this.pop());
        }
        else if(operands.length == 1)
        {
            num1 = Number(this.pop());
            num2 = Number(operands[0]);
        }
        else
        {
            num1 = Number(operands[0]);
            num2 = Number(operands[1]);
        }
        
        this.push([num1 / num2]);
        
    }
    
    private function mod(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = Number(this.pop());
            num1 = Number(this.pop());
        }
        else if(operands.length == 1)
        {
            num1 = Number(this.pop());
            num2 = Number(operands[0]);
        }
        else
        {
            num1 = Number(operands[0]);
            num2 = Number(operands[1]);
        }
        
        this.push([num1 % num2]);
        
    }
    
    private function pow(operands)
    {
        var num1;
        var num2;
        
        if(operands.length == 0)
        {
            num2 = Number(this.pop());
            num1 = Number(this.pop());
        }
        else if(operands.length == 1)
        {
            num1 = Number(this.pop());
            num2 = Number(operands[0]);
        }
        else
        {
            num1 = Number(operands[0]);
            num2 = Number(operands[1]);
        }
        
        this.push([Math.pow(num1, num2)]);
        
    }
    
    private function ext(operands)
    {
        var func;
        var args:Array = [];
        var numArgs;
        
        if(operands.length == 0)
        {
            func = this.pop();
            numArgs = this.pop();
            
            var i;
            for(i = 0; i < numArgs; i++)
            {
                args.push(this.pop());
            }
        }
        else if(operands.length == 1)
        {
            func = operands[0];
            numArgs = this.pop();
            
            var i;
            for(i = 0; i < numArgs; i++)
            {
                args.push(this.pop());
            }
        }
        else
        {
            func = operands[0];
            
            var i;
            for(i = 1; i < operands.length; i++)
            {
                args.push(operands[i]);
            }
        }
        
        var temp = eval(func).apply(null, args);
        if(temp)
        {
            this.push([temp]);
        }
    }
    
    private function map(operands)
    {
        var func;
        
        if(operands.length == 0)
        {
            func = this.pop();
        }
        else
        {
            func = operands[0];
        }
        
        set("_root." + func, function()
        {
           _root.KoopaShell.newInstrs(["call " + func]);
        });
    }
    
    private function call(operands)
    {
        var func;
        
        if(operands.length == 0)
        {
            func = this.pop();
        }
        else
        {
            func = operands[0];
        }
        
        this.push([_root.KoopaShell.pc]);
        
        _root.KoopaShell.pc = -1;
        
        var i;
        for(i = 0; i < funcs[func].length; i++)
        {
            _root.KoopaShell.queue.unshift(funcs[func][i]);
        }
    }
    
    private function ret(operands)
    {
        _root.KoopaShell.queue.splice(0, _root.KoopaShell.pc + 1);
        
        _root.KoopaShell.pc = this.pop();
    }
    
    public function execute(instr)
    {
        if(this[instr.opcode] != undefined)
        {
            if(this.execMode == 0)
            {
                this[instr.opcode](instr.operands);
            }
            else if(this.execMode == 1)
            {
                this.funcs[this.defFunc].unshift(instr.toString());
                if(instr.opcode == "ret")
                {
                    this.execMode = 0;
                    this.out(["Function saved"]);
                    this.defFunc = "";
                }
            }
        }
        else
        {
            this.out(["Invalid instruction"]);
        }
    }
    
}