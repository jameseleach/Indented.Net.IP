class IPv4Address {
    [ValidatePattern('^(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$')]
    [IPAddress]$IPAddress
    [IPv4Network]$Network

    # Constructors:
    # Parameterless Constructor
    IPv4Address() {
    }

    # Constructor with CIDR Notation
    IPv4Address([String]$Address) {
        [IPAddress]$this.IPAddress = $Address.split("/")[0]
        $this.Network = [IPv4Network]::New([String]$Address)
    }

    # Constructor with IP and Subnet Mask
    IPv4Address([IPAddress]$IPAddress, [IPAddress]$Mask){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[IPAddress]$Mask)
    }

    # Constructor with IP and Subnet Mask as strings
    IPv4Address([String]$IPAddress, [String]$Mask){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[IPAddress]$Mask)
    }
    
    # Constructor with IP Address and Mask Length
    IPv4Address([IPAddress]$IPAddress, [Int]$MaskLength){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[Int]$MaskLength)
    }

    # Constructor with IP Address, as string, and Mask Length
    IPv4Address([String]$IPAddress, [Int]$MaskLength){
        $this.IPAddress = [IPAddress]$IPAddress
        $this.Network = [IPv4Network]::New([IPAddress]$IPAddress,[Int]$MaskLength)
    }

    # Addition Method
    static [IPv4Address]op_Addition([IPv4Address]$Address, [Int]$Operand) {
        [IPAddress]$NewAddress = ConvertTo-DottedDecimalIP -IPAddress ((ConvertTo-DecimalIP -IPAddress $Address.IPAddress) + $Operand)
        return [IPv4Address]::New([IPAddress]$NewAddress,[Int]$Address.Network.MaskLength)
    }

    # Subtraction Method
    static [IPv4Address]op_Subtraction([IPv4Address]$Address, [Int]$Operand) {
        [IPAddress]$NewAddress = ConvertTo-DottedDecimalIP -IPAddress ((ConvertTo-DecimalIP -IPAddress $Address.IPAddress) - $Operand)
        return [IPv4Address]::New([IPAddress]$NewAddress,[Int]$Address.Network.MaskLength)
    }
}
