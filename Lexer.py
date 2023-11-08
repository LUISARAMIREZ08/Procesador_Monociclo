#HECHO POR LUISA FERNANDA RAMIREZ Y BRAYAN CATAÑO GIRALDO
from sly import Lexer

class RISCVLexer(Lexer):
    tokens = {INS_TYPE_R, INS_TYPE_I, INS_TYPE_I_LOAD, INS_TYPE_B, INS_TYPE_S, INS_TYPE_U, INS_TYPE_J, COMMA, REGISTER, INTEGER, COMMENT, NEWLINE, LPAREN, RPAREN, LABEL, COLON}
    
    # Definir tokens utilizando expresiones regulares
    INS_TYPE_R = r'\b(add|sub|xor|or|and|sll|srl|sra|slt|sltu|mul|div)\b'
    INS_TYPE_I = r'\b(addi|xori|ori|andi|slli|srli|srai|slti|sltiu|jalr)\b'
    INS_TYPE_I_LOAD = r'\b(lb|lh|lw|lhu|lbu)\b'
    INS_TYPE_S = r'\b(sb|sh|sw)\b'
    INS_TYPE_B = r'\b(beq|bne|blt|bge|bltu|bgeu)\b'
    INS_TYPE_U = r'\b(lui|auipc)\b'
    INS_TYPE_J = r'\b(jal)\b'
    COMMA = r','
    REGISTER = r'\b(zero|ra|sp|gp|tp|t0|t1|t2|s0|s1|a0|a1|a2|a3|a4|a5|a6|a7|s2|s3|s4|s5|s6|s7|s8|s9|s10|s11|t3|t4|t5|t6|x0|x1|x2|x3|x4|x5|x6|x7|x8|x9|x10|x11|x12|x13|x14|x15|x16|x17|x18|x19|x20|x21|x22|x23|x24|x25|x26|x27|x28|x29|x30|x31)\b'
    INTEGER = r'-?\d+'  #r'\d+'
    COMMENT = r'#.*'
    NEWLINE = r'\n'
    LPAREN = r'\('
    RPAREN = r'\)'
    LABEL = r'[a-zA-Z_][a-zA-Z0-9_]*'
    COLON = r':'

    # Ignored characters
    ignore = ' \t'

    # Newline tracking
    @_(r'\n(\s)*')
    def NEWLINE(self, t):
        self.lineno += 1
        return t

    @_(r'#.*')
    def COMMENT(self, t):
        pass  # Ignorar comentarios

    # Manejo de errores
    def error(self, t):
        print(f"Illegal character '{t.value[0]}'")
        self.index += 1

if __name__ == '__main__':
    lexer = RISCVLexer()
    input_string = """
    addi x1, x2, 10 # Esto es un comentario
    slli x3, x4, 2
    add x5, x6, x7
    sb x1, 10(x2)
    """
    for token in lexer.tokenize(input_string):
        print(f"Token Type: {token.type}, Value: {token.value}, Line: {token.lineno}")