pragma solidity 0.6.12;

contract Basics {
    //integer, string, bool, bytes
    //arrays, enum, struct, mapping (dictionary in python)
    int public a=4; // default =0
    int8 public b=10;
    int16 public c=20;
    //unsigned integers
    //uint8 = 256 - 0 to 255
    uint8 public d=30;
    uint public e=19;
    //string
    string public name="Raghu"; //default - ""
    //bool
    bool public tf = true; //default - false
    //bytes
    bytes public byteSample = "abc"; //0x616263
    bytes public byteSample2 = "ABC"; //0x414243
    //arrays - combination of same type of data
    string[] public students=["Raghu","John"]; //dynamic array
    string[15] public students2; //fixed length arrays
    int[] public sampleint=[1,2,3,4];
    // push, pop, length - are possible in solidity also
    //mapping
    mapping(string=>bool) public map;
    //enum - Enumeration - save storage, confine options for users
    enum Cities {LosAngeles, California, SanJose, Toronto}
    Cities public c1 = Cities.LosAngeles;
    Cities public c2 = Cities.SanJose;
    //struct
    struct Student {
        string name;
        bool attendance;
        int rollNo;
        int marks;
    }
    Student public student1;
} 

