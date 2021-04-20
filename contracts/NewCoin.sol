// SPDX-License-Identifier: MIT
pragma solidity =0.5.16;

contract NewCoin {
    // トークンの名前
    string public name;
    // トークンのシンボル
    string public symbol;
    //トークンが使用する小数点以下の桁数
    uint8 public decimals = 18;
    // トークンの合計供給量
    uint256 public totalSupply;
    // アドレス毎のアカウント残高
    mapping (address => uint256) public balances;
    mapping (address => mapping (address => uint256)) public allowed;

    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor() public {
        totalSupply = 100000000000000000000000;
        balances[msg.sender] = totalSupply;
        name = 'TEST';
        symbol = 'TST';
    }

    // アドレス毎のアカウント残高
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function _transfer(address _from, address _to, uint _value) internal {
        require(balances[_from] >= _value);
        require(_value > 0);
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
    }

    // 関数を呼び出した人からtoへトークンを送信する
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    // FromからToに送信する
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowed[_from][msg.sender]);
        _transfer(_from, _to, _value);
        allowed[_from][msg.sender] -= _value;
        return true;
    }

    // 関数を呼び出した人がspenderに対してトークンを引き出す
    function approve(address _spender, uint256 _value) public
    returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // ownerがspenderから引き出すことのできるトークンの量を返す
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}