class com.PracHack.KoopaShell.KoopaShell
{

    public var queue;
    public var pc;
    
    public var handler;
    
    private var queuestep;
    
    public function KoopaShell()
    {
        this.queue = new Array();
        this.pc = 0;
        
        this.handler = new com.PracHack.KoopaShell.InstructionHandler();
        
        this.queuestep = 32;
    }
    
    public function iter()
    {
        while(this.queue.length != 0 && this.queuestep != 0)
        {
            this.tick();
            this.queuestep--;
        }
        this.queuestep = 32;
    }
    
    private function tick()
    {
        var curInstr = new com.PracHack.KoopaShell.Mnemonic(this.queue[this.pc]);
        
        this.handler.execute(curInstr);
        
        this.pc++;
        
        if(this.pc >= this.queue.length)
        {
            this.queue.splice(0, this.queue.length);
            this.pc = 0;
        }
    }
    
    public function newInstrs(instrs)
    {
        var i;
        for(i = 0; i < instrs.length; i++)
        {
            this.queue.push(instrs[i]);
        }
    }
    
}