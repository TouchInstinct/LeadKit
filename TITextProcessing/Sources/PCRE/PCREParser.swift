// Generated from java-escape by ANTLR 4.11.1
import Antlr4

open class PCREParser: Parser {

	internal static var _decisionToDFA: [DFA] = {
          var decisionToDFA = [DFA]()
          let length = PCREParser._ATN.getNumberOfDecisions()
          for i in 0..<length {
            decisionToDFA.append(DFA(PCREParser._ATN.getDecisionState(i)!, i))
           }
           return decisionToDFA
     }()

	internal static let _sharedContextCache = PredictionContextCache()

	public
	enum Tokens: Int {
		case EOF = -1, Quoted = 1, BlockQuoted = 2, BellChar = 3, ControlChar = 4, 
                 EscapeChar = 5, FormFeed = 6, NewLine = 7, CarriageReturn = 8, 
                 Tab = 9, Backslash = 10, HexChar = 11, Dot = 12, OneDataUnit = 13, 
                 DecimalDigit = 14, NotDecimalDigit = 15, HorizontalWhiteSpace = 16, 
                 NotHorizontalWhiteSpace = 17, NotNewLine = 18, CharWithProperty = 19, 
                 CharWithoutProperty = 20, NewLineSequence = 21, WhiteSpace = 22, 
                 NotWhiteSpace = 23, VerticalWhiteSpace = 24, NotVerticalWhiteSpace = 25, 
                 WordChar = 26, NotWordChar = 27, ExtendedUnicodeChar = 28, 
                 CharacterClassStart = 29, CharacterClassEnd = 30, Caret = 31, 
                 Hyphen = 32, POSIXNamedSet = 33, POSIXNegatedNamedSet = 34, 
                 QuestionMark = 35, Plus = 36, Star = 37, OpenBrace = 38, 
                 CloseBrace = 39, Comma = 40, WordBoundary = 41, NonWordBoundary = 42, 
                 StartOfSubject = 43, EndOfSubjectOrLine = 44, EndOfSubjectOrLineEndOfSubject = 45, 
                 EndOfSubject = 46, PreviousMatchInSubject = 47, ResetStartMatch = 48, 
                 SubroutineOrNamedReferenceStartG = 49, NamedReferenceStartK = 50, 
                 Pipe = 51, OpenParen = 52, CloseParen = 53, LessThan = 54, 
                 GreaterThan = 55, SingleQuote = 56, Underscore = 57, Colon = 58, 
                 Hash = 59, Equals = 60, Exclamation = 61, Ampersand = 62, 
                 ALC = 63, BLC = 64, CLC = 65, DLC = 66, ELC = 67, FLC = 68, 
                 GLC = 69, HLC = 70, ILC = 71, JLC = 72, KLC = 73, LLC = 74, 
                 MLC = 75, NLC = 76, OLC = 77, PLC = 78, QLC = 79, RLC = 80, 
                 SLC = 81, TLC = 82, ULC = 83, VLC = 84, WLC = 85, XLC = 86, 
                 YLC = 87, ZLC = 88, AUC = 89, BUC = 90, CUC = 91, DUC = 92, 
                 EUC = 93, FUC = 94, GUC = 95, HUC = 96, IUC = 97, JUC = 98, 
                 KUC = 99, LUC = 100, MUC = 101, NUC = 102, OUC = 103, PUC = 104, 
                 QUC = 105, RUC = 106, SUC = 107, TUC = 108, UUC = 109, 
                 VUC = 110, WUC = 111, XUC = 112, YUC = 113, ZUC = 114, 
                 D1 = 115, D2 = 116, D3 = 117, D4 = 118, D5 = 119, D6 = 120, 
                 D7 = 121, D8 = 122, D9 = 123, D0 = 124, OtherChar = 125
	}

	public
	static let RULE_parse = 0, RULE_alternation = 1, RULE_expr = 2, RULE_element = 3, 
            RULE_quantifier = 4, RULE_quantifier_type = 5, RULE_character_class = 6, 
            RULE_backreference = 7, RULE_backreference_or_octal = 8, RULE_capture = 9, 
            RULE_non_capture = 10, RULE_comment = 11, RULE_option = 12, 
            RULE_option_flags = 13, RULE_option_flag = 14, RULE_look_around = 15, 
            RULE_subroutine_reference = 16, RULE_conditional = 17, RULE_backtrack_control = 18, 
            RULE_newline_convention = 19, RULE_callout = 20, RULE_atom = 21, 
            RULE_cc_atom = 22, RULE_shared_atom = 23, RULE_literal = 24, 
            RULE_cc_literal = 25, RULE_shared_literal = 26, RULE_number = 27, 
            RULE_octal_char = 28, RULE_octal_digit = 29, RULE_digits = 30, 
            RULE_digit = 31, RULE_name = 32, RULE_alpha_nums = 33, RULE_non_close_parens = 34, 
            RULE_non_close_paren = 35, RULE_letter = 36

	public
	static let ruleNames: [String] = [
		"parse", "alternation", "expr", "element", "quantifier", "quantifier_type", 
		"character_class", "backreference", "backreference_or_octal", "capture", 
		"non_capture", "comment", "option", "option_flags", "option_flag", "look_around", 
		"subroutine_reference", "conditional", "backtrack_control", "newline_convention", 
		"callout", "atom", "cc_atom", "shared_atom", "literal", "cc_literal", 
		"shared_literal", "number", "octal_char", "octal_digit", "digits", "digit", 
		"name", "alpha_nums", "non_close_parens", "non_close_paren", "letter"
	]

	private static let _LITERAL_NAMES: [String?] = [
		nil, nil, nil, "'\\a'", nil, "'\\e'", "'\\f'", "'\\n'", "'\\r'", "'\\t'", 
		"'\\'", nil, "'.'", "'\\C'", "'\\d'", "'\\D'", "'\\h'", "'\\H'", "'\\N'", 
		nil, nil, "'\\R'", "'\\s'", "'\\S'", "'\\v'", "'\\V'", "'\\w'", "'\\W'", 
		"'\\X'", "'['", "']'", "'^'", "'-'", nil, nil, "'?'", "'+'", "'*'", "'{'", 
		"'}'", "','", "'\\b'", "'\\B'", "'\\A'", "'$'", "'\\Z'", "'\\z'", "'\\G'", 
		"'\\K'", "'\\g'", "'\\k'", "'|'", "'('", "')'", "'<'", "'>'", "'''", "'_'", 
		"':'", "'#'", "'='", "'!'", "'&'", "'a'", "'b'", "'c'", "'d'", "'e'", 
		"'f'", "'g'", "'h'", "'i'", "'j'", "'k'", "'l'", "'m'", "'n'", "'o'", 
		"'p'", "'q'", "'r'", "'s'", "'t'", "'u'", "'v'", "'w'", "'x'", "'y'", 
		"'z'", "'A'", "'B'", "'C'", "'D'", "'E'", "'F'", "'G'", "'H'", "'I'", 
		"'J'", "'K'", "'L'", "'M'", "'N'", "'O'", "'P'", "'Q'", "'R'", "'S'", 
		"'T'", "'U'", "'V'", "'W'", "'X'", "'Y'", "'Z'", "'1'", "'2'", "'3'", 
		"'4'", "'5'", "'6'", "'7'", "'8'", "'9'", "'0'"
	]
	private static let _SYMBOLIC_NAMES: [String?] = [
		nil, "Quoted", "BlockQuoted", "BellChar", "ControlChar", "EscapeChar", 
		"FormFeed", "NewLine", "CarriageReturn", "Tab", "Backslash", "HexChar", 
		"Dot", "OneDataUnit", "DecimalDigit", "NotDecimalDigit", "HorizontalWhiteSpace", 
		"NotHorizontalWhiteSpace", "NotNewLine", "CharWithProperty", "CharWithoutProperty", 
		"NewLineSequence", "WhiteSpace", "NotWhiteSpace", "VerticalWhiteSpace", 
		"NotVerticalWhiteSpace", "WordChar", "NotWordChar", "ExtendedUnicodeChar", 
		"CharacterClassStart", "CharacterClassEnd", "Caret", "Hyphen", "POSIXNamedSet", 
		"POSIXNegatedNamedSet", "QuestionMark", "Plus", "Star", "OpenBrace", "CloseBrace", 
		"Comma", "WordBoundary", "NonWordBoundary", "StartOfSubject", "EndOfSubjectOrLine", 
		"EndOfSubjectOrLineEndOfSubject", "EndOfSubject", "PreviousMatchInSubject", 
		"ResetStartMatch", "SubroutineOrNamedReferenceStartG", "NamedReferenceStartK", 
		"Pipe", "OpenParen", "CloseParen", "LessThan", "GreaterThan", "SingleQuote", 
		"Underscore", "Colon", "Hash", "Equals", "Exclamation", "Ampersand", "ALC", 
		"BLC", "CLC", "DLC", "ELC", "FLC", "GLC", "HLC", "ILC", "JLC", "KLC", 
		"LLC", "MLC", "NLC", "OLC", "PLC", "QLC", "RLC", "SLC", "TLC", "ULC", 
		"VLC", "WLC", "XLC", "YLC", "ZLC", "AUC", "BUC", "CUC", "DUC", "EUC", 
		"FUC", "GUC", "HUC", "IUC", "JUC", "KUC", "LUC", "MUC", "NUC", "OUC", 
		"PUC", "QUC", "RUC", "SUC", "TUC", "UUC", "VUC", "WUC", "XUC", "YUC", 
		"ZUC", "D1", "D2", "D3", "D4", "D5", "D6", "D7", "D8", "D9", "D0", "OtherChar"
	]
	public
	static let VOCABULARY = Vocabulary(_LITERAL_NAMES, _SYMBOLIC_NAMES)

	override open
	func getGrammarFileName() -> String { return "java-escape" }

	override open
	func getRuleNames() -> [String] { return PCREParser.ruleNames }

	override open
	func getSerializedATN() -> [Int] { return PCREParser._serializedATN }

	override open
	func getATN() -> ATN { return PCREParser._ATN }


	override open
	func getVocabulary() -> Vocabulary {
	    return PCREParser.VOCABULARY
	}

	override public
	init(_ input:TokenStream) throws {
	    RuntimeMetaData.checkVersion("4.11.1", RuntimeMetaData.VERSION)
		try super.init(input)
		_interp = ParserATNSimulator(self,PCREParser._ATN,PCREParser._decisionToDFA, PCREParser._sharedContextCache)
	}


	public class ParseContext: ParserRuleContext {
			open
			func alternation() -> AlternationContext? {
				return getRuleContext(AlternationContext.self, 0)
			}
			open
			func EOF() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EOF.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_parse
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterParse(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitParse(self)
			}
		}
	}
	@discardableResult
	 open func parse() throws -> ParseContext {
		var _localctx: ParseContext
		_localctx = ParseContext(_ctx, getState())
		try enterRule(_localctx, 0, PCREParser.RULE_parse)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(74)
		 	try alternation()
		 	setState(75)
		 	try match(PCREParser.Tokens.EOF.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class AlternationContext: ParserRuleContext {
			open
			func expr() -> [ExprContext] {
				return getRuleContexts(ExprContext.self)
			}
			open
			func expr(_ i: Int) -> ExprContext? {
				return getRuleContext(ExprContext.self, i)
			}
			open
			func Pipe() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.Pipe.rawValue)
			}
			open
			func Pipe(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.Pipe.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_alternation
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterAlternation(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitAlternation(self)
			}
		}
	}
	@discardableResult
	 open func alternation() throws -> AlternationContext {
		var _localctx: AlternationContext
		_localctx = AlternationContext(_ctx, getState())
		try enterRule(_localctx, 2, PCREParser.RULE_alternation)
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(77)
		 	try expr()
		 	setState(82)
		 	try _errHandler.sync(self)
		 	_alt = try getInterpreter().adaptivePredict(_input,0,_ctx)
		 	while (_alt != 2 && _alt != ATN.INVALID_ALT_NUMBER) {
		 		if ( _alt==1 ) {
		 			setState(78)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(79)
		 			try expr()

		 	 
		 		}
		 		setState(84)
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,0,_ctx)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ExprContext: ParserRuleContext {
			open
			func element() -> [ElementContext] {
				return getRuleContexts(ElementContext.self)
			}
			open
			func element(_ i: Int) -> ElementContext? {
				return getRuleContext(ElementContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_expr
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterExpr(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitExpr(self)
			}
		}
	}
	@discardableResult
	 open func expr() throws -> ExprContext {
		var _localctx: ExprContext
		_localctx = ExprContext(_ctx, getState())
		try enterRule(_localctx, 4, PCREParser.RULE_expr)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(88)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -11259239586594818) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0) {
		 		setState(85)
		 		try element()


		 		setState(90)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ElementContext: ParserRuleContext {
			open
			func atom() -> AtomContext? {
				return getRuleContext(AtomContext.self, 0)
			}
			open
			func quantifier() -> QuantifierContext? {
				return getRuleContext(QuantifierContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_element
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterElement(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitElement(self)
			}
		}
	}
	@discardableResult
	 open func element() throws -> ElementContext {
		var _localctx: ElementContext
		_localctx = ElementContext(_ctx, getState())
		try enterRule(_localctx, 6, PCREParser.RULE_element)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(91)
		 	try atom()
		 	setState(93)
		 	try _errHandler.sync(self)
		 	switch (try getInterpreter().adaptivePredict(_input,2,_ctx)) {
		 	case 1:
		 		setState(92)
		 		try quantifier()

		 		break
		 	default: break
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class QuantifierContext: ParserRuleContext {
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func quantifier_type() -> Quantifier_typeContext? {
				return getRuleContext(Quantifier_typeContext.self, 0)
			}
			open
			func Plus() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Plus.rawValue, 0)
			}
			open
			func Star() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Star.rawValue, 0)
			}
			open
			func OpenBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenBrace.rawValue, 0)
			}
			open
			func number() -> [NumberContext] {
				return getRuleContexts(NumberContext.self)
			}
			open
			func number(_ i: Int) -> NumberContext? {
				return getRuleContext(NumberContext.self, i)
			}
			open
			func CloseBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseBrace.rawValue, 0)
			}
			open
			func Comma() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Comma.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_quantifier
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterQuantifier(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitQuantifier(self)
			}
		}
	}
	@discardableResult
	 open func quantifier() throws -> QuantifierContext {
		var _localctx: QuantifierContext
		_localctx = QuantifierContext(_ctx, getState())
		try enterRule(_localctx, 8, PCREParser.RULE_quantifier)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(119)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,3, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(95)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(96)
		 		try quantifier_type()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(97)
		 		try match(PCREParser.Tokens.Plus.rawValue)
		 		setState(98)
		 		try quantifier_type()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(99)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(100)
		 		try quantifier_type()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(101)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(102)
		 		try number()
		 		setState(103)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)
		 		setState(104)
		 		try quantifier_type()

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(106)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(107)
		 		try number()
		 		setState(108)
		 		try match(PCREParser.Tokens.Comma.rawValue)
		 		setState(109)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)
		 		setState(110)
		 		try quantifier_type()

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(112)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(113)
		 		try number()
		 		setState(114)
		 		try match(PCREParser.Tokens.Comma.rawValue)
		 		setState(115)
		 		try number()
		 		setState(116)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)
		 		setState(117)
		 		try quantifier_type()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Quantifier_typeContext: ParserRuleContext {
			open
			func Plus() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Plus.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_quantifier_type
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterQuantifier_type(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitQuantifier_type(self)
			}
		}
	}
	@discardableResult
	 open func quantifier_type() throws -> Quantifier_typeContext {
		var _localctx: Quantifier_typeContext
		_localctx = Quantifier_typeContext(_ctx, getState())
		try enterRule(_localctx, 10, PCREParser.RULE_quantifier_type)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(124)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .Plus:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(121)
		 		try match(PCREParser.Tokens.Plus.rawValue)

		 		break

		 	case .QuestionMark:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(122)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)

		 		break
		 	case .EOF:fallthrough
		 	case .Quoted:fallthrough
		 	case .BlockQuoted:fallthrough
		 	case .BellChar:fallthrough
		 	case .ControlChar:fallthrough
		 	case .EscapeChar:fallthrough
		 	case .FormFeed:fallthrough
		 	case .NewLine:fallthrough
		 	case .CarriageReturn:fallthrough
		 	case .Tab:fallthrough
		 	case .Backslash:fallthrough
		 	case .HexChar:fallthrough
		 	case .Dot:fallthrough
		 	case .OneDataUnit:fallthrough
		 	case .DecimalDigit:fallthrough
		 	case .NotDecimalDigit:fallthrough
		 	case .HorizontalWhiteSpace:fallthrough
		 	case .NotHorizontalWhiteSpace:fallthrough
		 	case .NotNewLine:fallthrough
		 	case .CharWithProperty:fallthrough
		 	case .CharWithoutProperty:fallthrough
		 	case .NewLineSequence:fallthrough
		 	case .WhiteSpace:fallthrough
		 	case .NotWhiteSpace:fallthrough
		 	case .VerticalWhiteSpace:fallthrough
		 	case .NotVerticalWhiteSpace:fallthrough
		 	case .WordChar:fallthrough
		 	case .NotWordChar:fallthrough
		 	case .ExtendedUnicodeChar:fallthrough
		 	case .CharacterClassStart:fallthrough
		 	case .CharacterClassEnd:fallthrough
		 	case .Caret:fallthrough
		 	case .Hyphen:fallthrough
		 	case .POSIXNamedSet:fallthrough
		 	case .POSIXNegatedNamedSet:fallthrough
		 	case .OpenBrace:fallthrough
		 	case .CloseBrace:fallthrough
		 	case .Comma:fallthrough
		 	case .WordBoundary:fallthrough
		 	case .NonWordBoundary:fallthrough
		 	case .StartOfSubject:fallthrough
		 	case .EndOfSubjectOrLine:fallthrough
		 	case .EndOfSubjectOrLineEndOfSubject:fallthrough
		 	case .EndOfSubject:fallthrough
		 	case .PreviousMatchInSubject:fallthrough
		 	case .ResetStartMatch:fallthrough
		 	case .SubroutineOrNamedReferenceStartG:fallthrough
		 	case .NamedReferenceStartK:fallthrough
		 	case .Pipe:fallthrough
		 	case .OpenParen:fallthrough
		 	case .CloseParen:fallthrough
		 	case .LessThan:fallthrough
		 	case .GreaterThan:fallthrough
		 	case .SingleQuote:fallthrough
		 	case .Underscore:fallthrough
		 	case .Colon:fallthrough
		 	case .Hash:fallthrough
		 	case .Equals:fallthrough
		 	case .Exclamation:fallthrough
		 	case .Ampersand:fallthrough
		 	case .ALC:fallthrough
		 	case .BLC:fallthrough
		 	case .CLC:fallthrough
		 	case .DLC:fallthrough
		 	case .ELC:fallthrough
		 	case .FLC:fallthrough
		 	case .GLC:fallthrough
		 	case .HLC:fallthrough
		 	case .ILC:fallthrough
		 	case .JLC:fallthrough
		 	case .KLC:fallthrough
		 	case .LLC:fallthrough
		 	case .MLC:fallthrough
		 	case .NLC:fallthrough
		 	case .OLC:fallthrough
		 	case .PLC:fallthrough
		 	case .QLC:fallthrough
		 	case .RLC:fallthrough
		 	case .SLC:fallthrough
		 	case .TLC:fallthrough
		 	case .ULC:fallthrough
		 	case .VLC:fallthrough
		 	case .WLC:fallthrough
		 	case .XLC:fallthrough
		 	case .YLC:fallthrough
		 	case .ZLC:fallthrough
		 	case .AUC:fallthrough
		 	case .BUC:fallthrough
		 	case .CUC:fallthrough
		 	case .DUC:fallthrough
		 	case .EUC:fallthrough
		 	case .FUC:fallthrough
		 	case .GUC:fallthrough
		 	case .HUC:fallthrough
		 	case .IUC:fallthrough
		 	case .JUC:fallthrough
		 	case .KUC:fallthrough
		 	case .LUC:fallthrough
		 	case .MUC:fallthrough
		 	case .NUC:fallthrough
		 	case .OUC:fallthrough
		 	case .PUC:fallthrough
		 	case .QUC:fallthrough
		 	case .RUC:fallthrough
		 	case .SUC:fallthrough
		 	case .TUC:fallthrough
		 	case .UUC:fallthrough
		 	case .VUC:fallthrough
		 	case .WUC:fallthrough
		 	case .XUC:fallthrough
		 	case .YUC:fallthrough
		 	case .ZUC:fallthrough
		 	case .D1:fallthrough
		 	case .D2:fallthrough
		 	case .D3:fallthrough
		 	case .D4:fallthrough
		 	case .D5:fallthrough
		 	case .D6:fallthrough
		 	case .D7:fallthrough
		 	case .D8:fallthrough
		 	case .D9:fallthrough
		 	case .D0:fallthrough
		 	case .OtherChar:
		 		try enterOuterAlt(_localctx, 3)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Character_classContext: ParserRuleContext {
			open
			func CharacterClassStart() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharacterClassStart.rawValue, 0)
			}
			open
			func Caret() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Caret.rawValue, 0)
			}
			open
			func CharacterClassEnd() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.CharacterClassEnd.rawValue)
			}
			open
			func CharacterClassEnd(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharacterClassEnd.rawValue, i)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func cc_atom() -> [Cc_atomContext] {
				return getRuleContexts(Cc_atomContext.self)
			}
			open
			func cc_atom(_ i: Int) -> Cc_atomContext? {
				return getRuleContext(Cc_atomContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_character_class
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterCharacter_class(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitCharacter_class(self)
			}
		}
	}
	@discardableResult
	 open func character_class() throws -> Character_classContext {
		var _localctx: Character_classContext
		_localctx = Character_classContext(_ctx, getState())
		try enterRule(_localctx, 12, PCREParser.RULE_character_class)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(183)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,11, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(126)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(127)
		 		try match(PCREParser.Tokens.Caret.rawValue)
		 		setState(128)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)
		 		setState(129)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(131) 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		repeat {
		 			setState(130)
		 			try cc_atom()


		 			setState(133); 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		} while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0)
		 		setState(135)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(137)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(138)
		 		try match(PCREParser.Tokens.Caret.rawValue)
		 		setState(139)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)
		 		setState(143)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0) {
		 			setState(140)
		 			try cc_atom()


		 			setState(145)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(146)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(147)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(148)
		 		try match(PCREParser.Tokens.Caret.rawValue)
		 		setState(150) 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		repeat {
		 			setState(149)
		 			try cc_atom()


		 			setState(152); 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		} while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0)
		 		setState(154)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(156)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(157)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)
		 		setState(158)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(160) 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		repeat {
		 			setState(159)
		 			try cc_atom()


		 			setState(162); 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		} while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0)
		 		setState(164)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(166)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(167)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)
		 		setState(171)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0) {
		 			setState(168)
		 			try cc_atom()


		 			setState(173)
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		}
		 		setState(174)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(175)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)
		 		setState(177) 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		repeat {
		 			setState(176)
		 			try cc_atom()


		 			setState(179); 
		 			try _errHandler.sync(self)
		 			_la = try _input.LA(1)
		 		} while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -2229810923315202) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0)
		 		setState(181)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class BackreferenceContext: ParserRuleContext {
			open
			func backreference_or_octal() -> Backreference_or_octalContext? {
				return getRuleContext(Backreference_or_octalContext.self, 0)
			}
			open
			func SubroutineOrNamedReferenceStartG() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue, 0)
			}
			open
			func number() -> NumberContext? {
				return getRuleContext(NumberContext.self, 0)
			}
			open
			func OpenBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenBrace.rawValue, 0)
			}
			open
			func CloseBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseBrace.rawValue, 0)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func NamedReferenceStartK() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NamedReferenceStartK.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
			open
			func name() -> NameContext? {
				return getRuleContext(NameContext.self, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func SingleQuote() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.SingleQuote.rawValue)
			}
			open
			func SingleQuote(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.SingleQuote.rawValue, i)
			}
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
			open
			func Equals() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Equals.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_backreference
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterBackreference(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitBackreference(self)
			}
		}
	}
	@discardableResult
	 open func backreference() throws -> BackreferenceContext {
		var _localctx: BackreferenceContext
		_localctx = BackreferenceContext(_ctx, getState())
		try enterRule(_localctx, 14, PCREParser.RULE_backreference)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(226)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,12, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(185)
		 		try backreference_or_octal()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(186)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(187)
		 		try number()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(188)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(189)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(190)
		 		try number()
		 		setState(191)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(193)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(194)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(195)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(196)
		 		try number()
		 		setState(197)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(199)
		 		try match(PCREParser.Tokens.NamedReferenceStartK.rawValue)
		 		setState(200)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(201)
		 		try name()
		 		setState(202)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(204)
		 		try match(PCREParser.Tokens.NamedReferenceStartK.rawValue)
		 		setState(205)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(206)
		 		try name()
		 		setState(207)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(209)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(210)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(211)
		 		try name()
		 		setState(212)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(214)
		 		try match(PCREParser.Tokens.NamedReferenceStartK.rawValue)
		 		setState(215)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)
		 		setState(216)
		 		try name()
		 		setState(217)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(219)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(220)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(221)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(222)
		 		try match(PCREParser.Tokens.Equals.rawValue)
		 		setState(223)
		 		try name()
		 		setState(224)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Backreference_or_octalContext: ParserRuleContext {
			open
			func octal_char() -> Octal_charContext? {
				return getRuleContext(Octal_charContext.self, 0)
			}
			open
			func Backslash() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Backslash.rawValue, 0)
			}
			open
			func digit() -> DigitContext? {
				return getRuleContext(DigitContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_backreference_or_octal
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterBackreference_or_octal(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitBackreference_or_octal(self)
			}
		}
	}
	@discardableResult
	 open func backreference_or_octal() throws -> Backreference_or_octalContext {
		var _localctx: Backreference_or_octalContext
		_localctx = Backreference_or_octalContext(_ctx, getState())
		try enterRule(_localctx, 16, PCREParser.RULE_backreference_or_octal)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(231)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,13, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(228)
		 		try octal_char()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(229)
		 		try match(PCREParser.Tokens.Backslash.rawValue)
		 		setState(230)
		 		try digit()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class CaptureContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
			open
			func name() -> NameContext? {
				return getRuleContext(NameContext.self, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func alternation() -> AlternationContext? {
				return getRuleContext(AlternationContext.self, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func SingleQuote() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.SingleQuote.rawValue)
			}
			open
			func SingleQuote(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.SingleQuote.rawValue, i)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_capture
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterCapture(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitCapture(self)
			}
		}
	}
	@discardableResult
	 open func capture() throws -> CaptureContext {
		var _localctx: CaptureContext
		_localctx = CaptureContext(_ctx, getState())
		try enterRule(_localctx, 18, PCREParser.RULE_capture)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(262)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,14, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(233)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(234)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(235)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(236)
		 		try name()
		 		setState(237)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)
		 		setState(238)
		 		try alternation()
		 		setState(239)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(241)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(242)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(243)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(244)
		 		try name()
		 		setState(245)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(246)
		 		try alternation()
		 		setState(247)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(249)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(250)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(251)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(252)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(253)
		 		try name()
		 		setState(254)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)
		 		setState(255)
		 		try alternation()
		 		setState(256)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(258)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(259)
		 		try alternation()
		 		setState(260)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Non_captureContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func Colon() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Colon.rawValue, 0)
			}
			open
			func alternation() -> AlternationContext? {
				return getRuleContext(AlternationContext.self, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func Pipe() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Pipe.rawValue, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func option_flags() -> Option_flagsContext? {
				return getRuleContext(Option_flagsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_non_capture
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterNon_capture(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitNon_capture(self)
			}
		}
	}
	@discardableResult
	 open func non_capture() throws -> Non_captureContext {
		var _localctx: Non_captureContext
		_localctx = Non_captureContext(_ctx, getState())
		try enterRule(_localctx, 20, PCREParser.RULE_non_capture)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(289)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,15, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(264)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(265)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(266)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(267)
		 		try alternation()
		 		setState(268)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(270)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(271)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(272)
		 		try match(PCREParser.Tokens.Pipe.rawValue)
		 		setState(273)
		 		try alternation()
		 		setState(274)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(276)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(277)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(278)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)
		 		setState(279)
		 		try alternation()
		 		setState(280)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(282)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(283)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(284)
		 		try option_flags()
		 		setState(285)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(286)
		 		try alternation()
		 		setState(287)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class CommentContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func Hash() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hash.rawValue, 0)
			}
			open
			func non_close_parens() -> Non_close_parensContext? {
				return getRuleContext(Non_close_parensContext.self, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_comment
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterComment(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitComment(self)
			}
		}
	}
	@discardableResult
	 open func comment() throws -> CommentContext {
		var _localctx: CommentContext
		_localctx = CommentContext(_ctx, getState())
		try enterRule(_localctx, 22, PCREParser.RULE_comment)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(291)
		 	try match(PCREParser.Tokens.OpenParen.rawValue)
		 	setState(292)
		 	try match(PCREParser.Tokens.QuestionMark.rawValue)
		 	setState(293)
		 	try match(PCREParser.Tokens.Hash.rawValue)
		 	setState(294)
		 	try non_close_parens()
		 	setState(295)
		 	try match(PCREParser.Tokens.CloseParen.rawValue)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class OptionContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func option_flags() -> [Option_flagsContext] {
				return getRuleContexts(Option_flagsContext.self)
			}
			open
			func option_flags(_ i: Int) -> Option_flagsContext? {
				return getRuleContext(Option_flagsContext.self, i)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func Star() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Star.rawValue, 0)
			}
			open
			func NUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NUC.rawValue, 0)
			}
			open
			func OUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.OUC.rawValue)
			}
			open
			func OUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.OUC.rawValue, i)
			}
			open
			func Underscore() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.Underscore.rawValue)
			}
			open
			func Underscore(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.Underscore.rawValue, i)
			}
			open
			func SUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SUC.rawValue, 0)
			}
			open
			func TUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.TUC.rawValue)
			}
			open
			func TUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.TUC.rawValue, i)
			}
			open
			func AUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.AUC.rawValue, 0)
			}
			open
			func RUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, 0)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
			open
			func UUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.UUC.rawValue, 0)
			}
			open
			func FUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FUC.rawValue, 0)
			}
			open
			func D8() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D8.rawValue, 0)
			}
			open
			func D1() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D1.rawValue, 0)
			}
			open
			func D6() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D6.rawValue, 0)
			}
			open
			func CUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CUC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_option
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterOption(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitOption(self)
			}
		}
	}
	@discardableResult
	 open func option() throws -> OptionContext {
		var _localctx: OptionContext
		_localctx = OptionContext(_ctx, getState())
		try enterRule(_localctx, 24, PCREParser.RULE_option)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(351)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,16, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(297)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(298)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(299)
		 		try option_flags()
		 		setState(300)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(301)
		 		try option_flags()
		 		setState(302)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(304)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(305)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(306)
		 		try option_flags()
		 		setState(307)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(309)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(310)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(311)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(312)
		 		try option_flags()
		 		setState(313)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(315)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(316)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(317)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(318)
		 		try match(PCREParser.Tokens.OUC.rawValue)
		 		setState(319)
		 		try match(PCREParser.Tokens.Underscore.rawValue)
		 		setState(320)
		 		try match(PCREParser.Tokens.SUC.rawValue)
		 		setState(321)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(322)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(323)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(324)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(325)
		 		try match(PCREParser.Tokens.Underscore.rawValue)
		 		setState(326)
		 		try match(PCREParser.Tokens.OUC.rawValue)
		 		setState(327)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(328)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(329)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(330)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(331)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(332)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(333)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(334)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(335)
		 		try match(PCREParser.Tokens.D8.rawValue)
		 		setState(336)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(337)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(338)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(339)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(340)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(341)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(342)
		 		try match(PCREParser.Tokens.D1.rawValue)
		 		setState(343)
		 		try match(PCREParser.Tokens.D6.rawValue)
		 		setState(344)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(345)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(346)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(347)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(348)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(349)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(350)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Option_flagsContext: ParserRuleContext {
			open
			func option_flag() -> [Option_flagContext] {
				return getRuleContexts(Option_flagContext.self)
			}
			open
			func option_flag(_ i: Int) -> Option_flagContext? {
				return getRuleContext(Option_flagContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_option_flags
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterOption_flags(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitOption_flags(self)
			}
		}
	}
	@discardableResult
	 open func option_flags() throws -> Option_flagsContext {
		var _localctx: Option_flagsContext
		_localctx = Option_flagsContext(_ctx, getState())
		try enterRule(_localctx, 26, PCREParser.RULE_option_flags)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(354) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(353)
		 		try option_flag()


		 		setState(356); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while ((Int64((_la - 71)) & ~0x3f) == 0 && ((Int64(1) << (_la - 71)) & 275012158481) != 0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Option_flagContext: ParserRuleContext {
			open
			func ILC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ILC.rawValue, 0)
			}
			open
			func JUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.JUC.rawValue, 0)
			}
			open
			func MLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.MLC.rawValue, 0)
			}
			open
			func SLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SLC.rawValue, 0)
			}
			open
			func UUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.UUC.rawValue, 0)
			}
			open
			func XLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.XLC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_option_flag
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterOption_flag(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitOption_flag(self)
			}
		}
	}
	@discardableResult
	 open func option_flag() throws -> Option_flagContext {
		var _localctx: Option_flagContext
		_localctx = Option_flagContext(_ctx, getState())
		try enterRule(_localctx, 28, PCREParser.RULE_option_flag)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(358)
		 	_la = try _input.LA(1)
		 	if (!((Int64((_la - 71)) & ~0x3f) == 0 && ((Int64(1) << (_la - 71)) & 275012158481) != 0)) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Look_aroundContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func Equals() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Equals.rawValue, 0)
			}
			open
			func alternation() -> AlternationContext? {
				return getRuleContext(AlternationContext.self, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func Exclamation() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Exclamation.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_look_around
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterLook_around(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitLook_around(self)
			}
		}
	}
	@discardableResult
	 open func look_around() throws -> Look_aroundContext {
		var _localctx: Look_aroundContext
		_localctx = Look_aroundContext(_ctx, getState())
		try enterRule(_localctx, 30, PCREParser.RULE_look_around)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(386)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,18, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(360)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(361)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(362)
		 		try match(PCREParser.Tokens.Equals.rawValue)
		 		setState(363)
		 		try alternation()
		 		setState(364)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(366)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(367)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(368)
		 		try match(PCREParser.Tokens.Exclamation.rawValue)
		 		setState(369)
		 		try alternation()
		 		setState(370)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(372)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(373)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(374)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(375)
		 		try match(PCREParser.Tokens.Equals.rawValue)
		 		setState(376)
		 		try alternation()
		 		setState(377)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(379)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(380)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(381)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(382)
		 		try match(PCREParser.Tokens.Exclamation.rawValue)
		 		setState(383)
		 		try alternation()
		 		setState(384)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Subroutine_referenceContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func RUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func number() -> NumberContext? {
				return getRuleContext(NumberContext.self, 0)
			}
			open
			func Plus() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Plus.rawValue, 0)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func Ampersand() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Ampersand.rawValue, 0)
			}
			open
			func name() -> NameContext? {
				return getRuleContext(NameContext.self, 0)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func SubroutineOrNamedReferenceStartG() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
			open
			func SingleQuote() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.SingleQuote.rawValue)
			}
			open
			func SingleQuote(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.SingleQuote.rawValue, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_subroutine_reference
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterSubroutine_reference(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitSubroutine_reference(self)
			}
		}
	}
	@discardableResult
	 open func subroutine_reference() throws -> Subroutine_referenceContext {
		var _localctx: Subroutine_referenceContext
		_localctx = Subroutine_referenceContext(_ctx, getState())
		try enterRule(_localctx, 32, PCREParser.RULE_subroutine_reference)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(466)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,19, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(388)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(389)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(390)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(391)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(392)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(393)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(394)
		 		try number()
		 		setState(395)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(397)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(398)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(399)
		 		try match(PCREParser.Tokens.Plus.rawValue)
		 		setState(400)
		 		try number()
		 		setState(401)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(403)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(404)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(405)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(406)
		 		try number()
		 		setState(407)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(409)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(410)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(411)
		 		try match(PCREParser.Tokens.Ampersand.rawValue)
		 		setState(412)
		 		try name()
		 		setState(413)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(415)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(416)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(417)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(418)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)
		 		setState(419)
		 		try name()
		 		setState(420)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(422)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(423)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(424)
		 		try name()
		 		setState(425)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(427)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(428)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(429)
		 		try name()
		 		setState(430)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(432)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(433)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(434)
		 		try number()
		 		setState(435)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break
		 	case 10:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(437)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(438)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(439)
		 		try number()
		 		setState(440)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break
		 	case 11:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(442)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(443)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(444)
		 		try match(PCREParser.Tokens.Plus.rawValue)
		 		setState(445)
		 		try number()
		 		setState(446)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break
		 	case 12:
		 		try enterOuterAlt(_localctx, 12)
		 		setState(448)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(449)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(450)
		 		try match(PCREParser.Tokens.Plus.rawValue)
		 		setState(451)
		 		try number()
		 		setState(452)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break
		 	case 13:
		 		try enterOuterAlt(_localctx, 13)
		 		setState(454)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(455)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(456)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(457)
		 		try number()
		 		setState(458)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break
		 	case 14:
		 		try enterOuterAlt(_localctx, 14)
		 		setState(460)
		 		try match(PCREParser.Tokens.SubroutineOrNamedReferenceStartG.rawValue)
		 		setState(461)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(462)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(463)
		 		try number()
		 		setState(464)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class ConditionalContext: ParserRuleContext {
			open
			func OpenParen() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.OpenParen.rawValue)
			}
			open
			func OpenParen(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, i)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func number() -> NumberContext? {
				return getRuleContext(NumberContext.self, 0)
			}
			open
			func CloseParen() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.CloseParen.rawValue)
			}
			open
			func CloseParen(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, i)
			}
			open
			func alternation() -> [AlternationContext] {
				return getRuleContexts(AlternationContext.self)
			}
			open
			func alternation(_ i: Int) -> AlternationContext? {
				return getRuleContext(AlternationContext.self, i)
			}
			open
			func Pipe() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Pipe.rawValue, 0)
			}
			open
			func Plus() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Plus.rawValue, 0)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
			open
			func name() -> NameContext? {
				return getRuleContext(NameContext.self, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func SingleQuote() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.SingleQuote.rawValue)
			}
			open
			func SingleQuote(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.SingleQuote.rawValue, i)
			}
			open
			func RUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, 0)
			}
			open
			func Ampersand() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Ampersand.rawValue, 0)
			}
			open
			func DUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.DUC.rawValue, 0)
			}
			open
			func EUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.EUC.rawValue)
			}
			open
			func EUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.EUC.rawValue, i)
			}
			open
			func FUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FUC.rawValue, 0)
			}
			open
			func IUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.IUC.rawValue, 0)
			}
			open
			func NUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NUC.rawValue, 0)
			}
			open
			func ALC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ALC.rawValue, 0)
			}
			open
			func SLC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.SLC.rawValue)
			}
			open
			func SLC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.SLC.rawValue, i)
			}
			open
			func ELC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ELC.rawValue, 0)
			}
			open
			func RLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RLC.rawValue, 0)
			}
			open
			func TLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.TLC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_conditional
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterConditional(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitConditional(self)
			}
		}
	}
	@discardableResult
	 open func conditional() throws -> ConditionalContext {
		var _localctx: ConditionalContext
		_localctx = ConditionalContext(_ctx, getState())
		try enterRule(_localctx, 34, PCREParser.RULE_conditional)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(619)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,31, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(468)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(469)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(470)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(471)
		 		try number()
		 		setState(472)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(473)
		 		try alternation()
		 		setState(476)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(474)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(475)
		 			try alternation()

		 		}

		 		setState(478)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(480)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(481)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(482)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(483)
		 		try match(PCREParser.Tokens.Plus.rawValue)
		 		setState(484)
		 		try number()
		 		setState(485)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(486)
		 		try alternation()
		 		setState(489)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(487)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(488)
		 			try alternation()

		 		}

		 		setState(491)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(493)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(494)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(495)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(496)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(497)
		 		try number()
		 		setState(498)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(499)
		 		try alternation()
		 		setState(502)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(500)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(501)
		 			try alternation()

		 		}

		 		setState(504)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(506)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(507)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(508)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(509)
		 		try match(PCREParser.Tokens.LessThan.rawValue)
		 		setState(510)
		 		try name()
		 		setState(511)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)
		 		setState(512)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(513)
		 		try alternation()
		 		setState(516)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(514)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(515)
		 			try alternation()

		 		}

		 		setState(518)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(520)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(521)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(522)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(523)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(524)
		 		try name()
		 		setState(525)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)
		 		setState(526)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(527)
		 		try alternation()
		 		setState(530)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(528)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(529)
		 			try alternation()

		 		}

		 		setState(532)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(534)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(535)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(536)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(537)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(538)
		 		try number()
		 		setState(539)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(540)
		 		try alternation()
		 		setState(543)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(541)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(542)
		 			try alternation()

		 		}

		 		setState(545)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(547)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(548)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(549)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(550)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(551)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(552)
		 		try alternation()
		 		setState(555)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(553)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(554)
		 			try alternation()

		 		}

		 		setState(557)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(559)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(560)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(561)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(562)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(563)
		 		try match(PCREParser.Tokens.Ampersand.rawValue)
		 		setState(564)
		 		try name()
		 		setState(565)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(566)
		 		try alternation()
		 		setState(569)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(567)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(568)
		 			try alternation()

		 		}

		 		setState(571)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(573)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(574)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(575)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(576)
		 		try match(PCREParser.Tokens.DUC.rawValue)
		 		setState(577)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(578)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(579)
		 		try match(PCREParser.Tokens.IUC.rawValue)
		 		setState(580)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(581)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(582)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(583)
		 		try alternation()
		 		setState(586)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(584)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(585)
		 			try alternation()

		 		}

		 		setState(588)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 10:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(590)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(591)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(592)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(593)
		 		try match(PCREParser.Tokens.ALC.rawValue)
		 		setState(594)
		 		try match(PCREParser.Tokens.SLC.rawValue)
		 		setState(595)
		 		try match(PCREParser.Tokens.SLC.rawValue)
		 		setState(596)
		 		try match(PCREParser.Tokens.ELC.rawValue)
		 		setState(597)
		 		try match(PCREParser.Tokens.RLC.rawValue)
		 		setState(598)
		 		try match(PCREParser.Tokens.TLC.rawValue)
		 		setState(599)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(600)
		 		try alternation()
		 		setState(603)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(601)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(602)
		 			try alternation()

		 		}

		 		setState(605)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 11:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(607)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(608)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(609)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(610)
		 		try name()
		 		setState(611)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)
		 		setState(612)
		 		try alternation()
		 		setState(615)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.Pipe.rawValue) {
		 			setState(613)
		 			try match(PCREParser.Tokens.Pipe.rawValue)
		 			setState(614)
		 			try alternation()

		 		}

		 		setState(617)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Backtrack_controlContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func Star() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Star.rawValue, 0)
			}
			open
			func AUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.AUC.rawValue)
			}
			open
			func AUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.AUC.rawValue, i)
			}
			open
			func CUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.CUC.rawValue)
			}
			open
			func CUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.CUC.rawValue, i)
			}
			open
			func EUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.EUC.rawValue)
			}
			open
			func EUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.EUC.rawValue, i)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
			open
			func TUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.TUC.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func FUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FUC.rawValue, 0)
			}
			open
			func IUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.IUC.rawValue, 0)
			}
			open
			func LUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LUC.rawValue, 0)
			}
			open
			func Colon() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Colon.rawValue, 0)
			}
			open
			func NUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.NUC.rawValue)
			}
			open
			func NUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.NUC.rawValue, i)
			}
			open
			func MUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.MUC.rawValue)
			}
			open
			func MUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.MUC.rawValue, i)
			}
			open
			func RUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, 0)
			}
			open
			func KUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.KUC.rawValue, 0)
			}
			open
			func OUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OUC.rawValue, 0)
			}
			open
			func UUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.UUC.rawValue, 0)
			}
			open
			func SUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SUC.rawValue, 0)
			}
			open
			func HUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.HUC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_backtrack_control
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterBacktrack_control(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitBacktrack_control(self)
			}
		}
	}
	@discardableResult
	 open func backtrack_control() throws -> Backtrack_controlContext {
		var _localctx: Backtrack_controlContext
		_localctx = Backtrack_controlContext(_ctx, getState())
		try enterRule(_localctx, 36, PCREParser.RULE_backtrack_control)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(721)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,34, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(621)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(622)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(623)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(624)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(625)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(626)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(627)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(628)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(629)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(630)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(631)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(632)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(636)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.AUC.rawValue) {
		 			setState(633)
		 			try match(PCREParser.Tokens.AUC.rawValue)
		 			setState(634)
		 			try match(PCREParser.Tokens.IUC.rawValue)
		 			setState(635)
		 			try match(PCREParser.Tokens.LUC.rawValue)

		 		}

		 		setState(638)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(639)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(640)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(645)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 		if (_la == PCREParser.Tokens.MUC.rawValue) {
		 			setState(641)
		 			try match(PCREParser.Tokens.MUC.rawValue)
		 			setState(642)
		 			try match(PCREParser.Tokens.AUC.rawValue)
		 			setState(643)
		 			try match(PCREParser.Tokens.RUC.rawValue)
		 			setState(644)
		 			try match(PCREParser.Tokens.KUC.rawValue)

		 		}

		 		setState(647)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(648)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(649)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(650)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(651)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(652)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(653)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(654)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(655)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(656)
		 		try match(PCREParser.Tokens.OUC.rawValue)
		 		setState(657)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(658)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(659)
		 		try match(PCREParser.Tokens.IUC.rawValue)
		 		setState(660)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(661)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(662)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(663)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(664)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(665)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(666)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(667)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(668)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(669)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(670)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(671)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(672)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(673)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(674)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(675)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(676)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(677)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(678)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(679)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(680)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(681)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(682)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(683)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(684)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(685)
		 		try match(PCREParser.Tokens.SUC.rawValue)
		 		setState(686)
		 		try match(PCREParser.Tokens.KUC.rawValue)
		 		setState(687)
		 		try match(PCREParser.Tokens.IUC.rawValue)
		 		setState(688)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(689)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(690)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(691)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(692)
		 		try match(PCREParser.Tokens.SUC.rawValue)
		 		setState(693)
		 		try match(PCREParser.Tokens.KUC.rawValue)
		 		setState(694)
		 		try match(PCREParser.Tokens.IUC.rawValue)
		 		setState(695)
		 		try match(PCREParser.Tokens.PUC.rawValue)
		 		setState(696)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(697)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(698)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(699)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(700)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(701)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(702)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(703)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(704)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(705)
		 		try match(PCREParser.Tokens.HUC.rawValue)
		 		setState(706)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(707)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(708)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 10:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(709)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(710)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(711)
		 		try match(PCREParser.Tokens.TUC.rawValue)
		 		setState(712)
		 		try match(PCREParser.Tokens.HUC.rawValue)
		 		setState(713)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(714)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(715)
		 		try match(PCREParser.Tokens.Colon.rawValue)
		 		setState(716)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(717)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(718)
		 		try match(PCREParser.Tokens.MUC.rawValue)
		 		setState(719)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(720)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Newline_conventionContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func Star() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Star.rawValue, 0)
			}
			open
			func CUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CUC.rawValue, 0)
			}
			open
			func RUC() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.RUC.rawValue)
			}
			open
			func RUC(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, i)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func LUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LUC.rawValue, 0)
			}
			open
			func FUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FUC.rawValue, 0)
			}
			open
			func AUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.AUC.rawValue, 0)
			}
			open
			func NUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NUC.rawValue, 0)
			}
			open
			func YUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.YUC.rawValue, 0)
			}
			open
			func BUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.BUC.rawValue, 0)
			}
			open
			func SUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SUC.rawValue, 0)
			}
			open
			func Underscore() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Underscore.rawValue, 0)
			}
			open
			func UUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.UUC.rawValue, 0)
			}
			open
			func IUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.IUC.rawValue, 0)
			}
			open
			func OUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OUC.rawValue, 0)
			}
			open
			func DUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.DUC.rawValue, 0)
			}
			open
			func EUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EUC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_newline_convention
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterNewline_convention(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitNewline_convention(self)
			}
		}
	}
	@discardableResult
	 open func newline_convention() throws -> Newline_conventionContext {
		var _localctx: Newline_conventionContext
		_localctx = Newline_conventionContext(_ctx, getState())
		try enterRule(_localctx, 38, PCREParser.RULE_newline_convention)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(784)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,35, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(723)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(724)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(725)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(726)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(727)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(728)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(729)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(730)
		 		try match(PCREParser.Tokens.LUC.rawValue)
		 		setState(731)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(732)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(733)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(734)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(735)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(736)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(737)
		 		try match(PCREParser.Tokens.LUC.rawValue)
		 		setState(738)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(739)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(740)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(741)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(742)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(743)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(744)
		 		try match(PCREParser.Tokens.YUC.rawValue)
		 		setState(745)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(746)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(747)
		 		try match(PCREParser.Tokens.LUC.rawValue)
		 		setState(748)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(749)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(750)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(751)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(752)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(753)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(754)
		 		try match(PCREParser.Tokens.YUC.rawValue)
		 		setState(755)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(756)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(757)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(758)
		 		try match(PCREParser.Tokens.BUC.rawValue)
		 		setState(759)
		 		try match(PCREParser.Tokens.SUC.rawValue)
		 		setState(760)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(761)
		 		try match(PCREParser.Tokens.Underscore.rawValue)
		 		setState(762)
		 		try match(PCREParser.Tokens.AUC.rawValue)
		 		setState(763)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(764)
		 		try match(PCREParser.Tokens.YUC.rawValue)
		 		setState(765)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(766)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(767)
		 		try match(PCREParser.Tokens.LUC.rawValue)
		 		setState(768)
		 		try match(PCREParser.Tokens.FUC.rawValue)
		 		setState(769)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(770)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(771)
		 		try match(PCREParser.Tokens.Star.rawValue)
		 		setState(772)
		 		try match(PCREParser.Tokens.BUC.rawValue)
		 		setState(773)
		 		try match(PCREParser.Tokens.SUC.rawValue)
		 		setState(774)
		 		try match(PCREParser.Tokens.RUC.rawValue)
		 		setState(775)
		 		try match(PCREParser.Tokens.Underscore.rawValue)
		 		setState(776)
		 		try match(PCREParser.Tokens.UUC.rawValue)
		 		setState(777)
		 		try match(PCREParser.Tokens.NUC.rawValue)
		 		setState(778)
		 		try match(PCREParser.Tokens.IUC.rawValue)
		 		setState(779)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(780)
		 		try match(PCREParser.Tokens.OUC.rawValue)
		 		setState(781)
		 		try match(PCREParser.Tokens.DUC.rawValue)
		 		setState(782)
		 		try match(PCREParser.Tokens.EUC.rawValue)
		 		setState(783)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class CalloutContext: ParserRuleContext {
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func CUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CUC.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
			open
			func number() -> NumberContext? {
				return getRuleContext(NumberContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_callout
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterCallout(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitCallout(self)
			}
		}
	}
	@discardableResult
	 open func callout() throws -> CalloutContext {
		var _localctx: CalloutContext
		_localctx = CalloutContext(_ctx, getState())
		try enterRule(_localctx, 40, PCREParser.RULE_callout)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(796)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,36, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(786)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(787)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(788)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(789)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(790)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)
		 		setState(791)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)
		 		setState(792)
		 		try match(PCREParser.Tokens.CUC.rawValue)
		 		setState(793)
		 		try number()
		 		setState(794)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class AtomContext: ParserRuleContext {
			open
			func subroutine_reference() -> Subroutine_referenceContext? {
				return getRuleContext(Subroutine_referenceContext.self, 0)
			}
			open
			func shared_atom() -> Shared_atomContext? {
				return getRuleContext(Shared_atomContext.self, 0)
			}
			open
			func literal() -> LiteralContext? {
				return getRuleContext(LiteralContext.self, 0)
			}
			open
			func character_class() -> Character_classContext? {
				return getRuleContext(Character_classContext.self, 0)
			}
			open
			func capture() -> CaptureContext? {
				return getRuleContext(CaptureContext.self, 0)
			}
			open
			func non_capture() -> Non_captureContext? {
				return getRuleContext(Non_captureContext.self, 0)
			}
			open
			func comment() -> CommentContext? {
				return getRuleContext(CommentContext.self, 0)
			}
			open
			func option() -> OptionContext? {
				return getRuleContext(OptionContext.self, 0)
			}
			open
			func look_around() -> Look_aroundContext? {
				return getRuleContext(Look_aroundContext.self, 0)
			}
			open
			func backreference() -> BackreferenceContext? {
				return getRuleContext(BackreferenceContext.self, 0)
			}
			open
			func conditional() -> ConditionalContext? {
				return getRuleContext(ConditionalContext.self, 0)
			}
			open
			func backtrack_control() -> Backtrack_controlContext? {
				return getRuleContext(Backtrack_controlContext.self, 0)
			}
			open
			func newline_convention() -> Newline_conventionContext? {
				return getRuleContext(Newline_conventionContext.self, 0)
			}
			open
			func callout() -> CalloutContext? {
				return getRuleContext(CalloutContext.self, 0)
			}
			open
			func Dot() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Dot.rawValue, 0)
			}
			open
			func Caret() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Caret.rawValue, 0)
			}
			open
			func StartOfSubject() -> TerminalNode? {
				return getToken(PCREParser.Tokens.StartOfSubject.rawValue, 0)
			}
			open
			func WordBoundary() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WordBoundary.rawValue, 0)
			}
			open
			func NonWordBoundary() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NonWordBoundary.rawValue, 0)
			}
			open
			func EndOfSubjectOrLine() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EndOfSubjectOrLine.rawValue, 0)
			}
			open
			func EndOfSubjectOrLineEndOfSubject() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EndOfSubjectOrLineEndOfSubject.rawValue, 0)
			}
			open
			func EndOfSubject() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EndOfSubject.rawValue, 0)
			}
			open
			func PreviousMatchInSubject() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PreviousMatchInSubject.rawValue, 0)
			}
			open
			func ResetStartMatch() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ResetStartMatch.rawValue, 0)
			}
			open
			func OneDataUnit() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OneDataUnit.rawValue, 0)
			}
			open
			func ExtendedUnicodeChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ExtendedUnicodeChar.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_atom
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterAtom(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitAtom(self)
			}
		}
	}
	@discardableResult
	 open func atom() throws -> AtomContext {
		var _localctx: AtomContext
		_localctx = AtomContext(_ctx, getState())
		try enterRule(_localctx, 42, PCREParser.RULE_atom)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(824)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,37, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(798)
		 		try subroutine_reference()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(799)
		 		try shared_atom()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(800)
		 		try literal()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(801)
		 		try character_class()

		 		break
		 	case 5:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(802)
		 		try capture()

		 		break
		 	case 6:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(803)
		 		try non_capture()

		 		break
		 	case 7:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(804)
		 		try comment()

		 		break
		 	case 8:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(805)
		 		try option()

		 		break
		 	case 9:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(806)
		 		try look_around()

		 		break
		 	case 10:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(807)
		 		try backreference()

		 		break
		 	case 11:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(808)
		 		try conditional()

		 		break
		 	case 12:
		 		try enterOuterAlt(_localctx, 12)
		 		setState(809)
		 		try backtrack_control()

		 		break
		 	case 13:
		 		try enterOuterAlt(_localctx, 13)
		 		setState(810)
		 		try newline_convention()

		 		break
		 	case 14:
		 		try enterOuterAlt(_localctx, 14)
		 		setState(811)
		 		try callout()

		 		break
		 	case 15:
		 		try enterOuterAlt(_localctx, 15)
		 		setState(812)
		 		try match(PCREParser.Tokens.Dot.rawValue)

		 		break
		 	case 16:
		 		try enterOuterAlt(_localctx, 16)
		 		setState(813)
		 		try match(PCREParser.Tokens.Caret.rawValue)

		 		break
		 	case 17:
		 		try enterOuterAlt(_localctx, 17)
		 		setState(814)
		 		try match(PCREParser.Tokens.StartOfSubject.rawValue)

		 		break
		 	case 18:
		 		try enterOuterAlt(_localctx, 18)
		 		setState(815)
		 		try match(PCREParser.Tokens.WordBoundary.rawValue)

		 		break
		 	case 19:
		 		try enterOuterAlt(_localctx, 19)
		 		setState(816)
		 		try match(PCREParser.Tokens.NonWordBoundary.rawValue)

		 		break
		 	case 20:
		 		try enterOuterAlt(_localctx, 20)
		 		setState(817)
		 		try match(PCREParser.Tokens.EndOfSubjectOrLine.rawValue)

		 		break
		 	case 21:
		 		try enterOuterAlt(_localctx, 21)
		 		setState(818)
		 		try match(PCREParser.Tokens.EndOfSubjectOrLineEndOfSubject.rawValue)

		 		break
		 	case 22:
		 		try enterOuterAlt(_localctx, 22)
		 		setState(819)
		 		try match(PCREParser.Tokens.EndOfSubject.rawValue)

		 		break
		 	case 23:
		 		try enterOuterAlt(_localctx, 23)
		 		setState(820)
		 		try match(PCREParser.Tokens.PreviousMatchInSubject.rawValue)

		 		break
		 	case 24:
		 		try enterOuterAlt(_localctx, 24)
		 		setState(821)
		 		try match(PCREParser.Tokens.ResetStartMatch.rawValue)

		 		break
		 	case 25:
		 		try enterOuterAlt(_localctx, 25)
		 		setState(822)
		 		try match(PCREParser.Tokens.OneDataUnit.rawValue)

		 		break
		 	case 26:
		 		try enterOuterAlt(_localctx, 26)
		 		setState(823)
		 		try match(PCREParser.Tokens.ExtendedUnicodeChar.rawValue)

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Cc_atomContext: ParserRuleContext {
			open
			func cc_literal() -> [Cc_literalContext] {
				return getRuleContexts(Cc_literalContext.self)
			}
			open
			func cc_literal(_ i: Int) -> Cc_literalContext? {
				return getRuleContext(Cc_literalContext.self, i)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func shared_atom() -> Shared_atomContext? {
				return getRuleContext(Shared_atomContext.self, 0)
			}
			open
			func backreference_or_octal() -> Backreference_or_octalContext? {
				return getRuleContext(Backreference_or_octalContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_cc_atom
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterCc_atom(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitCc_atom(self)
			}
		}
	}
	@discardableResult
	 open func cc_atom() throws -> Cc_atomContext {
		var _localctx: Cc_atomContext
		_localctx = Cc_atomContext(_ctx, getState())
		try enterRule(_localctx, 44, PCREParser.RULE_cc_atom)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(833)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,38, _ctx)) {
		 	case 1:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(826)
		 		try cc_literal()
		 		setState(827)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)
		 		setState(828)
		 		try cc_literal()

		 		break
		 	case 2:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(830)
		 		try shared_atom()

		 		break
		 	case 3:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(831)
		 		try cc_literal()

		 		break
		 	case 4:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(832)
		 		try backreference_or_octal()

		 		break
		 	default: break
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Shared_atomContext: ParserRuleContext {
			open
			func POSIXNamedSet() -> TerminalNode? {
				return getToken(PCREParser.Tokens.POSIXNamedSet.rawValue, 0)
			}
			open
			func POSIXNegatedNamedSet() -> TerminalNode? {
				return getToken(PCREParser.Tokens.POSIXNegatedNamedSet.rawValue, 0)
			}
			open
			func ControlChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ControlChar.rawValue, 0)
			}
			open
			func DecimalDigit() -> TerminalNode? {
				return getToken(PCREParser.Tokens.DecimalDigit.rawValue, 0)
			}
			open
			func NotDecimalDigit() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotDecimalDigit.rawValue, 0)
			}
			open
			func HorizontalWhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.HorizontalWhiteSpace.rawValue, 0)
			}
			open
			func NotHorizontalWhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotHorizontalWhiteSpace.rawValue, 0)
			}
			open
			func NotNewLine() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotNewLine.rawValue, 0)
			}
			open
			func CharWithProperty() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharWithProperty.rawValue, 0)
			}
			open
			func CharWithoutProperty() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharWithoutProperty.rawValue, 0)
			}
			open
			func NewLineSequence() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NewLineSequence.rawValue, 0)
			}
			open
			func WhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WhiteSpace.rawValue, 0)
			}
			open
			func NotWhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotWhiteSpace.rawValue, 0)
			}
			open
			func VerticalWhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.VerticalWhiteSpace.rawValue, 0)
			}
			open
			func NotVerticalWhiteSpace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotVerticalWhiteSpace.rawValue, 0)
			}
			open
			func WordChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WordChar.rawValue, 0)
			}
			open
			func NotWordChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NotWordChar.rawValue, 0)
			}
			open
			func Backslash() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Backslash.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_shared_atom
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterShared_atom(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitShared_atom(self)
			}
		}
	}
	@discardableResult
	 open func shared_atom() throws -> Shared_atomContext {
		var _localctx: Shared_atomContext
		_localctx = Shared_atomContext(_ctx, getState())
		try enterRule(_localctx, 46, PCREParser.RULE_shared_atom)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(854)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .POSIXNamedSet:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(835)
		 		try match(PCREParser.Tokens.POSIXNamedSet.rawValue)

		 		break

		 	case .POSIXNegatedNamedSet:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(836)
		 		try match(PCREParser.Tokens.POSIXNegatedNamedSet.rawValue)

		 		break

		 	case .ControlChar:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(837)
		 		try match(PCREParser.Tokens.ControlChar.rawValue)

		 		break

		 	case .DecimalDigit:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(838)
		 		try match(PCREParser.Tokens.DecimalDigit.rawValue)

		 		break

		 	case .NotDecimalDigit:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(839)
		 		try match(PCREParser.Tokens.NotDecimalDigit.rawValue)

		 		break

		 	case .HorizontalWhiteSpace:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(840)
		 		try match(PCREParser.Tokens.HorizontalWhiteSpace.rawValue)

		 		break

		 	case .NotHorizontalWhiteSpace:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(841)
		 		try match(PCREParser.Tokens.NotHorizontalWhiteSpace.rawValue)

		 		break

		 	case .NotNewLine:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(842)
		 		try match(PCREParser.Tokens.NotNewLine.rawValue)

		 		break

		 	case .CharWithProperty:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(843)
		 		try match(PCREParser.Tokens.CharWithProperty.rawValue)

		 		break

		 	case .CharWithoutProperty:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(844)
		 		try match(PCREParser.Tokens.CharWithoutProperty.rawValue)

		 		break

		 	case .NewLineSequence:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(845)
		 		try match(PCREParser.Tokens.NewLineSequence.rawValue)

		 		break

		 	case .WhiteSpace:
		 		try enterOuterAlt(_localctx, 12)
		 		setState(846)
		 		try match(PCREParser.Tokens.WhiteSpace.rawValue)

		 		break

		 	case .NotWhiteSpace:
		 		try enterOuterAlt(_localctx, 13)
		 		setState(847)
		 		try match(PCREParser.Tokens.NotWhiteSpace.rawValue)

		 		break

		 	case .VerticalWhiteSpace:
		 		try enterOuterAlt(_localctx, 14)
		 		setState(848)
		 		try match(PCREParser.Tokens.VerticalWhiteSpace.rawValue)

		 		break

		 	case .NotVerticalWhiteSpace:
		 		try enterOuterAlt(_localctx, 15)
		 		setState(849)
		 		try match(PCREParser.Tokens.NotVerticalWhiteSpace.rawValue)

		 		break

		 	case .WordChar:
		 		try enterOuterAlt(_localctx, 16)
		 		setState(850)
		 		try match(PCREParser.Tokens.WordChar.rawValue)

		 		break

		 	case .NotWordChar:
		 		try enterOuterAlt(_localctx, 17)
		 		setState(851)
		 		try match(PCREParser.Tokens.NotWordChar.rawValue)

		 		break

		 	case .Backslash:
		 		try enterOuterAlt(_localctx, 18)
		 		setState(852)
		 		try match(PCREParser.Tokens.Backslash.rawValue)
		 		setState(853)
		 		try matchWildcard();

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class LiteralContext: ParserRuleContext {
			open
			func shared_literal() -> Shared_literalContext? {
				return getRuleContext(Shared_literalContext.self, 0)
			}
			open
			func CharacterClassEnd() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharacterClassEnd.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_literal
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterLiteral(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitLiteral(self)
			}
		}
	}
	@discardableResult
	 open func literal() throws -> LiteralContext {
		var _localctx: LiteralContext
		_localctx = LiteralContext(_ctx, getState())
		try enterRule(_localctx, 48, PCREParser.RULE_literal)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(858)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .Quoted:fallthrough
		 	case .BlockQuoted:fallthrough
		 	case .BellChar:fallthrough
		 	case .EscapeChar:fallthrough
		 	case .FormFeed:fallthrough
		 	case .NewLine:fallthrough
		 	case .CarriageReturn:fallthrough
		 	case .Tab:fallthrough
		 	case .Backslash:fallthrough
		 	case .HexChar:fallthrough
		 	case .Hyphen:fallthrough
		 	case .OpenBrace:fallthrough
		 	case .CloseBrace:fallthrough
		 	case .Comma:fallthrough
		 	case .LessThan:fallthrough
		 	case .GreaterThan:fallthrough
		 	case .SingleQuote:fallthrough
		 	case .Underscore:fallthrough
		 	case .Colon:fallthrough
		 	case .Hash:fallthrough
		 	case .Equals:fallthrough
		 	case .Exclamation:fallthrough
		 	case .Ampersand:fallthrough
		 	case .ALC:fallthrough
		 	case .BLC:fallthrough
		 	case .CLC:fallthrough
		 	case .DLC:fallthrough
		 	case .ELC:fallthrough
		 	case .FLC:fallthrough
		 	case .GLC:fallthrough
		 	case .HLC:fallthrough
		 	case .ILC:fallthrough
		 	case .JLC:fallthrough
		 	case .KLC:fallthrough
		 	case .LLC:fallthrough
		 	case .MLC:fallthrough
		 	case .NLC:fallthrough
		 	case .OLC:fallthrough
		 	case .PLC:fallthrough
		 	case .QLC:fallthrough
		 	case .RLC:fallthrough
		 	case .SLC:fallthrough
		 	case .TLC:fallthrough
		 	case .ULC:fallthrough
		 	case .VLC:fallthrough
		 	case .WLC:fallthrough
		 	case .XLC:fallthrough
		 	case .YLC:fallthrough
		 	case .ZLC:fallthrough
		 	case .AUC:fallthrough
		 	case .BUC:fallthrough
		 	case .CUC:fallthrough
		 	case .DUC:fallthrough
		 	case .EUC:fallthrough
		 	case .FUC:fallthrough
		 	case .GUC:fallthrough
		 	case .HUC:fallthrough
		 	case .IUC:fallthrough
		 	case .JUC:fallthrough
		 	case .KUC:fallthrough
		 	case .LUC:fallthrough
		 	case .MUC:fallthrough
		 	case .NUC:fallthrough
		 	case .OUC:fallthrough
		 	case .PUC:fallthrough
		 	case .QUC:fallthrough
		 	case .RUC:fallthrough
		 	case .SUC:fallthrough
		 	case .TUC:fallthrough
		 	case .UUC:fallthrough
		 	case .VUC:fallthrough
		 	case .WUC:fallthrough
		 	case .XUC:fallthrough
		 	case .YUC:fallthrough
		 	case .ZUC:fallthrough
		 	case .D1:fallthrough
		 	case .D2:fallthrough
		 	case .D3:fallthrough
		 	case .D4:fallthrough
		 	case .D5:fallthrough
		 	case .D6:fallthrough
		 	case .D7:fallthrough
		 	case .D8:fallthrough
		 	case .D9:fallthrough
		 	case .D0:fallthrough
		 	case .OtherChar:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(856)
		 		try shared_literal()

		 		break

		 	case .CharacterClassEnd:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(857)
		 		try match(PCREParser.Tokens.CharacterClassEnd.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Cc_literalContext: ParserRuleContext {
			open
			func shared_literal() -> Shared_literalContext? {
				return getRuleContext(Shared_literalContext.self, 0)
			}
			open
			func Dot() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Dot.rawValue, 0)
			}
			open
			func CharacterClassStart() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CharacterClassStart.rawValue, 0)
			}
			open
			func Caret() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Caret.rawValue, 0)
			}
			open
			func QuestionMark() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QuestionMark.rawValue, 0)
			}
			open
			func Plus() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Plus.rawValue, 0)
			}
			open
			func Star() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Star.rawValue, 0)
			}
			open
			func WordBoundary() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WordBoundary.rawValue, 0)
			}
			open
			func EndOfSubjectOrLine() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EndOfSubjectOrLine.rawValue, 0)
			}
			open
			func Pipe() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Pipe.rawValue, 0)
			}
			open
			func OpenParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenParen.rawValue, 0)
			}
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_cc_literal
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterCc_literal(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitCc_literal(self)
			}
		}
	}
	@discardableResult
	 open func cc_literal() throws -> Cc_literalContext {
		var _localctx: Cc_literalContext
		_localctx = Cc_literalContext(_ctx, getState())
		try enterRule(_localctx, 50, PCREParser.RULE_cc_literal)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(872)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .Quoted:fallthrough
		 	case .BlockQuoted:fallthrough
		 	case .BellChar:fallthrough
		 	case .EscapeChar:fallthrough
		 	case .FormFeed:fallthrough
		 	case .NewLine:fallthrough
		 	case .CarriageReturn:fallthrough
		 	case .Tab:fallthrough
		 	case .Backslash:fallthrough
		 	case .HexChar:fallthrough
		 	case .Hyphen:fallthrough
		 	case .OpenBrace:fallthrough
		 	case .CloseBrace:fallthrough
		 	case .Comma:fallthrough
		 	case .LessThan:fallthrough
		 	case .GreaterThan:fallthrough
		 	case .SingleQuote:fallthrough
		 	case .Underscore:fallthrough
		 	case .Colon:fallthrough
		 	case .Hash:fallthrough
		 	case .Equals:fallthrough
		 	case .Exclamation:fallthrough
		 	case .Ampersand:fallthrough
		 	case .ALC:fallthrough
		 	case .BLC:fallthrough
		 	case .CLC:fallthrough
		 	case .DLC:fallthrough
		 	case .ELC:fallthrough
		 	case .FLC:fallthrough
		 	case .GLC:fallthrough
		 	case .HLC:fallthrough
		 	case .ILC:fallthrough
		 	case .JLC:fallthrough
		 	case .KLC:fallthrough
		 	case .LLC:fallthrough
		 	case .MLC:fallthrough
		 	case .NLC:fallthrough
		 	case .OLC:fallthrough
		 	case .PLC:fallthrough
		 	case .QLC:fallthrough
		 	case .RLC:fallthrough
		 	case .SLC:fallthrough
		 	case .TLC:fallthrough
		 	case .ULC:fallthrough
		 	case .VLC:fallthrough
		 	case .WLC:fallthrough
		 	case .XLC:fallthrough
		 	case .YLC:fallthrough
		 	case .ZLC:fallthrough
		 	case .AUC:fallthrough
		 	case .BUC:fallthrough
		 	case .CUC:fallthrough
		 	case .DUC:fallthrough
		 	case .EUC:fallthrough
		 	case .FUC:fallthrough
		 	case .GUC:fallthrough
		 	case .HUC:fallthrough
		 	case .IUC:fallthrough
		 	case .JUC:fallthrough
		 	case .KUC:fallthrough
		 	case .LUC:fallthrough
		 	case .MUC:fallthrough
		 	case .NUC:fallthrough
		 	case .OUC:fallthrough
		 	case .PUC:fallthrough
		 	case .QUC:fallthrough
		 	case .RUC:fallthrough
		 	case .SUC:fallthrough
		 	case .TUC:fallthrough
		 	case .UUC:fallthrough
		 	case .VUC:fallthrough
		 	case .WUC:fallthrough
		 	case .XUC:fallthrough
		 	case .YUC:fallthrough
		 	case .ZUC:fallthrough
		 	case .D1:fallthrough
		 	case .D2:fallthrough
		 	case .D3:fallthrough
		 	case .D4:fallthrough
		 	case .D5:fallthrough
		 	case .D6:fallthrough
		 	case .D7:fallthrough
		 	case .D8:fallthrough
		 	case .D9:fallthrough
		 	case .D0:fallthrough
		 	case .OtherChar:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(860)
		 		try shared_literal()

		 		break

		 	case .Dot:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(861)
		 		try match(PCREParser.Tokens.Dot.rawValue)

		 		break

		 	case .CharacterClassStart:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(862)
		 		try match(PCREParser.Tokens.CharacterClassStart.rawValue)

		 		break

		 	case .Caret:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(863)
		 		try match(PCREParser.Tokens.Caret.rawValue)

		 		break

		 	case .QuestionMark:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(864)
		 		try match(PCREParser.Tokens.QuestionMark.rawValue)

		 		break

		 	case .Plus:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(865)
		 		try match(PCREParser.Tokens.Plus.rawValue)

		 		break

		 	case .Star:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(866)
		 		try match(PCREParser.Tokens.Star.rawValue)

		 		break

		 	case .WordBoundary:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(867)
		 		try match(PCREParser.Tokens.WordBoundary.rawValue)

		 		break

		 	case .EndOfSubjectOrLine:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(868)
		 		try match(PCREParser.Tokens.EndOfSubjectOrLine.rawValue)

		 		break

		 	case .Pipe:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(869)
		 		try match(PCREParser.Tokens.Pipe.rawValue)

		 		break

		 	case .OpenParen:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(870)
		 		try match(PCREParser.Tokens.OpenParen.rawValue)

		 		break

		 	case .CloseParen:
		 		try enterOuterAlt(_localctx, 12)
		 		setState(871)
		 		try match(PCREParser.Tokens.CloseParen.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Shared_literalContext: ParserRuleContext {
			open
			func octal_char() -> Octal_charContext? {
				return getRuleContext(Octal_charContext.self, 0)
			}
			open
			func letter() -> LetterContext? {
				return getRuleContext(LetterContext.self, 0)
			}
			open
			func digit() -> DigitContext? {
				return getRuleContext(DigitContext.self, 0)
			}
			open
			func BellChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.BellChar.rawValue, 0)
			}
			open
			func EscapeChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EscapeChar.rawValue, 0)
			}
			open
			func FormFeed() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FormFeed.rawValue, 0)
			}
			open
			func NewLine() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NewLine.rawValue, 0)
			}
			open
			func CarriageReturn() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CarriageReturn.rawValue, 0)
			}
			open
			func Tab() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Tab.rawValue, 0)
			}
			open
			func HexChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.HexChar.rawValue, 0)
			}
			open
			func Quoted() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Quoted.rawValue, 0)
			}
			open
			func BlockQuoted() -> TerminalNode? {
				return getToken(PCREParser.Tokens.BlockQuoted.rawValue, 0)
			}
			open
			func OpenBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OpenBrace.rawValue, 0)
			}
			open
			func CloseBrace() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseBrace.rawValue, 0)
			}
			open
			func Comma() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Comma.rawValue, 0)
			}
			open
			func Hyphen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hyphen.rawValue, 0)
			}
			open
			func LessThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LessThan.rawValue, 0)
			}
			open
			func GreaterThan() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GreaterThan.rawValue, 0)
			}
			open
			func SingleQuote() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SingleQuote.rawValue, 0)
			}
			open
			func Underscore() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Underscore.rawValue, 0)
			}
			open
			func Colon() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Colon.rawValue, 0)
			}
			open
			func Hash() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Hash.rawValue, 0)
			}
			open
			func Equals() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Equals.rawValue, 0)
			}
			open
			func Exclamation() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Exclamation.rawValue, 0)
			}
			open
			func Ampersand() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Ampersand.rawValue, 0)
			}
			open
			func OtherChar() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OtherChar.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_shared_literal
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterShared_literal(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitShared_literal(self)
			}
		}
	}
	@discardableResult
	 open func shared_literal() throws -> Shared_literalContext {
		var _localctx: Shared_literalContext
		_localctx = Shared_literalContext(_ctx, getState())
		try enterRule(_localctx, 52, PCREParser.RULE_shared_literal)
		defer {
	    		try! exitRule()
	    }
		do {
		 	setState(900)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .Backslash:
		 		try enterOuterAlt(_localctx, 1)
		 		setState(874)
		 		try octal_char()

		 		break
		 	case .ALC:fallthrough
		 	case .BLC:fallthrough
		 	case .CLC:fallthrough
		 	case .DLC:fallthrough
		 	case .ELC:fallthrough
		 	case .FLC:fallthrough
		 	case .GLC:fallthrough
		 	case .HLC:fallthrough
		 	case .ILC:fallthrough
		 	case .JLC:fallthrough
		 	case .KLC:fallthrough
		 	case .LLC:fallthrough
		 	case .MLC:fallthrough
		 	case .NLC:fallthrough
		 	case .OLC:fallthrough
		 	case .PLC:fallthrough
		 	case .QLC:fallthrough
		 	case .RLC:fallthrough
		 	case .SLC:fallthrough
		 	case .TLC:fallthrough
		 	case .ULC:fallthrough
		 	case .VLC:fallthrough
		 	case .WLC:fallthrough
		 	case .XLC:fallthrough
		 	case .YLC:fallthrough
		 	case .ZLC:fallthrough
		 	case .AUC:fallthrough
		 	case .BUC:fallthrough
		 	case .CUC:fallthrough
		 	case .DUC:fallthrough
		 	case .EUC:fallthrough
		 	case .FUC:fallthrough
		 	case .GUC:fallthrough
		 	case .HUC:fallthrough
		 	case .IUC:fallthrough
		 	case .JUC:fallthrough
		 	case .KUC:fallthrough
		 	case .LUC:fallthrough
		 	case .MUC:fallthrough
		 	case .NUC:fallthrough
		 	case .OUC:fallthrough
		 	case .PUC:fallthrough
		 	case .QUC:fallthrough
		 	case .RUC:fallthrough
		 	case .SUC:fallthrough
		 	case .TUC:fallthrough
		 	case .UUC:fallthrough
		 	case .VUC:fallthrough
		 	case .WUC:fallthrough
		 	case .XUC:fallthrough
		 	case .YUC:fallthrough
		 	case .ZUC:
		 		try enterOuterAlt(_localctx, 2)
		 		setState(875)
		 		try letter()

		 		break
		 	case .D1:fallthrough
		 	case .D2:fallthrough
		 	case .D3:fallthrough
		 	case .D4:fallthrough
		 	case .D5:fallthrough
		 	case .D6:fallthrough
		 	case .D7:fallthrough
		 	case .D8:fallthrough
		 	case .D9:fallthrough
		 	case .D0:
		 		try enterOuterAlt(_localctx, 3)
		 		setState(876)
		 		try digit()

		 		break

		 	case .BellChar:
		 		try enterOuterAlt(_localctx, 4)
		 		setState(877)
		 		try match(PCREParser.Tokens.BellChar.rawValue)

		 		break

		 	case .EscapeChar:
		 		try enterOuterAlt(_localctx, 5)
		 		setState(878)
		 		try match(PCREParser.Tokens.EscapeChar.rawValue)

		 		break

		 	case .FormFeed:
		 		try enterOuterAlt(_localctx, 6)
		 		setState(879)
		 		try match(PCREParser.Tokens.FormFeed.rawValue)

		 		break

		 	case .NewLine:
		 		try enterOuterAlt(_localctx, 7)
		 		setState(880)
		 		try match(PCREParser.Tokens.NewLine.rawValue)

		 		break

		 	case .CarriageReturn:
		 		try enterOuterAlt(_localctx, 8)
		 		setState(881)
		 		try match(PCREParser.Tokens.CarriageReturn.rawValue)

		 		break

		 	case .Tab:
		 		try enterOuterAlt(_localctx, 9)
		 		setState(882)
		 		try match(PCREParser.Tokens.Tab.rawValue)

		 		break

		 	case .HexChar:
		 		try enterOuterAlt(_localctx, 10)
		 		setState(883)
		 		try match(PCREParser.Tokens.HexChar.rawValue)

		 		break

		 	case .Quoted:
		 		try enterOuterAlt(_localctx, 11)
		 		setState(884)
		 		try match(PCREParser.Tokens.Quoted.rawValue)

		 		break

		 	case .BlockQuoted:
		 		try enterOuterAlt(_localctx, 12)
		 		setState(885)
		 		try match(PCREParser.Tokens.BlockQuoted.rawValue)

		 		break

		 	case .OpenBrace:
		 		try enterOuterAlt(_localctx, 13)
		 		setState(886)
		 		try match(PCREParser.Tokens.OpenBrace.rawValue)

		 		break

		 	case .CloseBrace:
		 		try enterOuterAlt(_localctx, 14)
		 		setState(887)
		 		try match(PCREParser.Tokens.CloseBrace.rawValue)

		 		break

		 	case .Comma:
		 		try enterOuterAlt(_localctx, 15)
		 		setState(888)
		 		try match(PCREParser.Tokens.Comma.rawValue)

		 		break

		 	case .Hyphen:
		 		try enterOuterAlt(_localctx, 16)
		 		setState(889)
		 		try match(PCREParser.Tokens.Hyphen.rawValue)

		 		break

		 	case .LessThan:
		 		try enterOuterAlt(_localctx, 17)
		 		setState(890)
		 		try match(PCREParser.Tokens.LessThan.rawValue)

		 		break

		 	case .GreaterThan:
		 		try enterOuterAlt(_localctx, 18)
		 		setState(891)
		 		try match(PCREParser.Tokens.GreaterThan.rawValue)

		 		break

		 	case .SingleQuote:
		 		try enterOuterAlt(_localctx, 19)
		 		setState(892)
		 		try match(PCREParser.Tokens.SingleQuote.rawValue)

		 		break

		 	case .Underscore:
		 		try enterOuterAlt(_localctx, 20)
		 		setState(893)
		 		try match(PCREParser.Tokens.Underscore.rawValue)

		 		break

		 	case .Colon:
		 		try enterOuterAlt(_localctx, 21)
		 		setState(894)
		 		try match(PCREParser.Tokens.Colon.rawValue)

		 		break

		 	case .Hash:
		 		try enterOuterAlt(_localctx, 22)
		 		setState(895)
		 		try match(PCREParser.Tokens.Hash.rawValue)

		 		break

		 	case .Equals:
		 		try enterOuterAlt(_localctx, 23)
		 		setState(896)
		 		try match(PCREParser.Tokens.Equals.rawValue)

		 		break

		 	case .Exclamation:
		 		try enterOuterAlt(_localctx, 24)
		 		setState(897)
		 		try match(PCREParser.Tokens.Exclamation.rawValue)

		 		break

		 	case .Ampersand:
		 		try enterOuterAlt(_localctx, 25)
		 		setState(898)
		 		try match(PCREParser.Tokens.Ampersand.rawValue)

		 		break

		 	case .OtherChar:
		 		try enterOuterAlt(_localctx, 26)
		 		setState(899)
		 		try match(PCREParser.Tokens.OtherChar.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class NumberContext: ParserRuleContext {
			open
			func digits() -> DigitsContext? {
				return getRuleContext(DigitsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_number
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterNumber(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitNumber(self)
			}
		}
	}
	@discardableResult
	 open func number() throws -> NumberContext {
		var _localctx: NumberContext
		_localctx = NumberContext(_ctx, getState())
		try enterRule(_localctx, 54, PCREParser.RULE_number)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(902)
		 	try digits()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Octal_charContext: ParserRuleContext {
			open
			func Backslash() -> TerminalNode? {
				return getToken(PCREParser.Tokens.Backslash.rawValue, 0)
			}
			open
			func octal_digit() -> [Octal_digitContext] {
				return getRuleContexts(Octal_digitContext.self)
			}
			open
			func octal_digit(_ i: Int) -> Octal_digitContext? {
				return getRuleContext(Octal_digitContext.self, i)
			}
			open
			func D0() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D0.rawValue, 0)
			}
			open
			func D1() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D1.rawValue, 0)
			}
			open
			func D2() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D2.rawValue, 0)
			}
			open
			func D3() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D3.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_octal_char
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterOctal_char(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitOctal_char(self)
			}
		}
	}
	@discardableResult
	 open func octal_char() throws -> Octal_charContext {
		var _localctx: Octal_charContext
		_localctx = Octal_charContext(_ctx, getState())
		try enterRule(_localctx, 56, PCREParser.RULE_octal_char)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(913)
		 	try _errHandler.sync(self)
		 	switch(try getInterpreter().adaptivePredict(_input,43, _ctx)) {
		 	case 1:
		 		setState(904)
		 		try match(PCREParser.Tokens.Backslash.rawValue)
		 		setState(905)
		 		_la = try _input.LA(1)
		 		if (!((Int64((_la - 115)) & ~0x3f) == 0 && ((Int64(1) << (_la - 115)) & 519) != 0)) {
		 		try _errHandler.recoverInline(self)
		 		}
		 		else {
		 			_errHandler.reportMatch(self)
		 			try consume()
		 		}
		 		setState(906)
		 		try octal_digit()
		 		setState(907)
		 		try octal_digit()

		 		break
		 	case 2:
		 		setState(909)
		 		try match(PCREParser.Tokens.Backslash.rawValue)
		 		setState(910)
		 		try octal_digit()
		 		setState(911)
		 		try octal_digit()

		 		break
		 	default: break
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Octal_digitContext: ParserRuleContext {
			open
			func D0() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D0.rawValue, 0)
			}
			open
			func D1() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D1.rawValue, 0)
			}
			open
			func D2() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D2.rawValue, 0)
			}
			open
			func D3() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D3.rawValue, 0)
			}
			open
			func D4() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D4.rawValue, 0)
			}
			open
			func D5() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D5.rawValue, 0)
			}
			open
			func D6() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D6.rawValue, 0)
			}
			open
			func D7() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D7.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_octal_digit
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterOctal_digit(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitOctal_digit(self)
			}
		}
	}
	@discardableResult
	 open func octal_digit() throws -> Octal_digitContext {
		var _localctx: Octal_digitContext
		_localctx = Octal_digitContext(_ctx, getState())
		try enterRule(_localctx, 58, PCREParser.RULE_octal_digit)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(915)
		 	_la = try _input.LA(1)
		 	if (!((Int64((_la - 115)) & ~0x3f) == 0 && ((Int64(1) << (_la - 115)) & 639) != 0)) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class DigitsContext: ParserRuleContext {
			open
			func digit() -> [DigitContext] {
				return getRuleContexts(DigitContext.self)
			}
			open
			func digit(_ i: Int) -> DigitContext? {
				return getRuleContext(DigitContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_digits
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterDigits(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitDigits(self)
			}
		}
	}
	@discardableResult
	 open func digits() throws -> DigitsContext {
		var _localctx: DigitsContext
		_localctx = DigitsContext(_ctx, getState())
		try enterRule(_localctx, 60, PCREParser.RULE_digits)
		defer {
	    		try! exitRule()
	    }
		do {
			var _alt:Int
		 	try enterOuterAlt(_localctx, 1)
		 	setState(918); 
		 	try _errHandler.sync(self)
		 	_alt = 1;
		 	repeat {
		 		switch (_alt) {
		 		case 1:
		 			setState(917)
		 			try digit()


		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}
		 		setState(920); 
		 		try _errHandler.sync(self)
		 		_alt = try getInterpreter().adaptivePredict(_input,44,_ctx)
		 	} while (_alt != 2 && _alt !=  ATN.INVALID_ALT_NUMBER)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class DigitContext: ParserRuleContext {
			open
			func D0() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D0.rawValue, 0)
			}
			open
			func D1() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D1.rawValue, 0)
			}
			open
			func D2() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D2.rawValue, 0)
			}
			open
			func D3() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D3.rawValue, 0)
			}
			open
			func D4() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D4.rawValue, 0)
			}
			open
			func D5() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D5.rawValue, 0)
			}
			open
			func D6() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D6.rawValue, 0)
			}
			open
			func D7() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D7.rawValue, 0)
			}
			open
			func D8() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D8.rawValue, 0)
			}
			open
			func D9() -> TerminalNode? {
				return getToken(PCREParser.Tokens.D9.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_digit
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterDigit(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitDigit(self)
			}
		}
	}
	@discardableResult
	 open func digit() throws -> DigitContext {
		var _localctx: DigitContext
		_localctx = DigitContext(_ctx, getState())
		try enterRule(_localctx, 62, PCREParser.RULE_digit)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(922)
		 	_la = try _input.LA(1)
		 	if (!((Int64((_la - 115)) & ~0x3f) == 0 && ((Int64(1) << (_la - 115)) & 1023) != 0)) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class NameContext: ParserRuleContext {
			open
			func alpha_nums() -> Alpha_numsContext? {
				return getRuleContext(Alpha_numsContext.self, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_name
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterName(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitName(self)
			}
		}
	}
	@discardableResult
	 open func name() throws -> NameContext {
		var _localctx: NameContext
		_localctx = NameContext(_ctx, getState())
		try enterRule(_localctx, 64, PCREParser.RULE_name)
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(924)
		 	try alpha_nums()

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Alpha_numsContext: ParserRuleContext {
			open
			func letter() -> [LetterContext] {
				return getRuleContexts(LetterContext.self)
			}
			open
			func letter(_ i: Int) -> LetterContext? {
				return getRuleContext(LetterContext.self, i)
			}
			open
			func Underscore() -> [TerminalNode] {
				return getTokens(PCREParser.Tokens.Underscore.rawValue)
			}
			open
			func Underscore(_ i:Int) -> TerminalNode? {
				return getToken(PCREParser.Tokens.Underscore.rawValue, i)
			}
			open
			func digit() -> [DigitContext] {
				return getRuleContexts(DigitContext.self)
			}
			open
			func digit(_ i: Int) -> DigitContext? {
				return getRuleContext(DigitContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_alpha_nums
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterAlpha_nums(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitAlpha_nums(self)
			}
		}
	}
	@discardableResult
	 open func alpha_nums() throws -> Alpha_numsContext {
		var _localctx: Alpha_numsContext
		_localctx = Alpha_numsContext(_ctx, getState())
		try enterRule(_localctx, 66, PCREParser.RULE_alpha_nums)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(928)
		 	try _errHandler.sync(self)
		 	switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 	case .ALC:fallthrough
		 	case .BLC:fallthrough
		 	case .CLC:fallthrough
		 	case .DLC:fallthrough
		 	case .ELC:fallthrough
		 	case .FLC:fallthrough
		 	case .GLC:fallthrough
		 	case .HLC:fallthrough
		 	case .ILC:fallthrough
		 	case .JLC:fallthrough
		 	case .KLC:fallthrough
		 	case .LLC:fallthrough
		 	case .MLC:fallthrough
		 	case .NLC:fallthrough
		 	case .OLC:fallthrough
		 	case .PLC:fallthrough
		 	case .QLC:fallthrough
		 	case .RLC:fallthrough
		 	case .SLC:fallthrough
		 	case .TLC:fallthrough
		 	case .ULC:fallthrough
		 	case .VLC:fallthrough
		 	case .WLC:fallthrough
		 	case .XLC:fallthrough
		 	case .YLC:fallthrough
		 	case .ZLC:fallthrough
		 	case .AUC:fallthrough
		 	case .BUC:fallthrough
		 	case .CUC:fallthrough
		 	case .DUC:fallthrough
		 	case .EUC:fallthrough
		 	case .FUC:fallthrough
		 	case .GUC:fallthrough
		 	case .HUC:fallthrough
		 	case .IUC:fallthrough
		 	case .JUC:fallthrough
		 	case .KUC:fallthrough
		 	case .LUC:fallthrough
		 	case .MUC:fallthrough
		 	case .NUC:fallthrough
		 	case .OUC:fallthrough
		 	case .PUC:fallthrough
		 	case .QUC:fallthrough
		 	case .RUC:fallthrough
		 	case .SUC:fallthrough
		 	case .TUC:fallthrough
		 	case .UUC:fallthrough
		 	case .VUC:fallthrough
		 	case .WUC:fallthrough
		 	case .XUC:fallthrough
		 	case .YUC:fallthrough
		 	case .ZUC:
		 		setState(926)
		 		try letter()

		 		break

		 	case .Underscore:
		 		setState(927)
		 		try match(PCREParser.Tokens.Underscore.rawValue)

		 		break
		 	default:
		 		throw ANTLRException.recognition(e: NoViableAltException(self))
		 	}
		 	setState(935)
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	while (_la == PCREParser.Tokens.Underscore.rawValue || _la == PCREParser.Tokens.ALC.rawValue || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 2305843009213693951) != 0) {
		 		setState(933)
		 		try _errHandler.sync(self)
		 		switch (PCREParser.Tokens(rawValue: try _input.LA(1))!) {
		 		case .ALC:fallthrough
		 		case .BLC:fallthrough
		 		case .CLC:fallthrough
		 		case .DLC:fallthrough
		 		case .ELC:fallthrough
		 		case .FLC:fallthrough
		 		case .GLC:fallthrough
		 		case .HLC:fallthrough
		 		case .ILC:fallthrough
		 		case .JLC:fallthrough
		 		case .KLC:fallthrough
		 		case .LLC:fallthrough
		 		case .MLC:fallthrough
		 		case .NLC:fallthrough
		 		case .OLC:fallthrough
		 		case .PLC:fallthrough
		 		case .QLC:fallthrough
		 		case .RLC:fallthrough
		 		case .SLC:fallthrough
		 		case .TLC:fallthrough
		 		case .ULC:fallthrough
		 		case .VLC:fallthrough
		 		case .WLC:fallthrough
		 		case .XLC:fallthrough
		 		case .YLC:fallthrough
		 		case .ZLC:fallthrough
		 		case .AUC:fallthrough
		 		case .BUC:fallthrough
		 		case .CUC:fallthrough
		 		case .DUC:fallthrough
		 		case .EUC:fallthrough
		 		case .FUC:fallthrough
		 		case .GUC:fallthrough
		 		case .HUC:fallthrough
		 		case .IUC:fallthrough
		 		case .JUC:fallthrough
		 		case .KUC:fallthrough
		 		case .LUC:fallthrough
		 		case .MUC:fallthrough
		 		case .NUC:fallthrough
		 		case .OUC:fallthrough
		 		case .PUC:fallthrough
		 		case .QUC:fallthrough
		 		case .RUC:fallthrough
		 		case .SUC:fallthrough
		 		case .TUC:fallthrough
		 		case .UUC:fallthrough
		 		case .VUC:fallthrough
		 		case .WUC:fallthrough
		 		case .XUC:fallthrough
		 		case .YUC:fallthrough
		 		case .ZUC:
		 			setState(930)
		 			try letter()

		 			break

		 		case .Underscore:
		 			setState(931)
		 			try match(PCREParser.Tokens.Underscore.rawValue)

		 			break
		 		case .D1:fallthrough
		 		case .D2:fallthrough
		 		case .D3:fallthrough
		 		case .D4:fallthrough
		 		case .D5:fallthrough
		 		case .D6:fallthrough
		 		case .D7:fallthrough
		 		case .D8:fallthrough
		 		case .D9:fallthrough
		 		case .D0:
		 			setState(932)
		 			try digit()

		 			break
		 		default:
		 			throw ANTLRException.recognition(e: NoViableAltException(self))
		 		}

		 		setState(937)
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Non_close_parensContext: ParserRuleContext {
			open
			func non_close_paren() -> [Non_close_parenContext] {
				return getRuleContexts(Non_close_parenContext.self)
			}
			open
			func non_close_paren(_ i: Int) -> Non_close_parenContext? {
				return getRuleContext(Non_close_parenContext.self, i)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_non_close_parens
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterNon_close_parens(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitNon_close_parens(self)
			}
		}
	}
	@discardableResult
	 open func non_close_parens() throws -> Non_close_parensContext {
		var _localctx: Non_close_parensContext
		_localctx = Non_close_parensContext(_ctx, getState())
		try enterRule(_localctx, 68, PCREParser.RULE_non_close_parens)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(939) 
		 	try _errHandler.sync(self)
		 	_la = try _input.LA(1)
		 	repeat {
		 		setState(938)
		 		try non_close_paren()


		 		setState(941); 
		 		try _errHandler.sync(self)
		 		_la = try _input.LA(1)
		 	} while ((Int64(_la) & ~0x3f) == 0 && ((Int64(1) << _la) & -9007199254740994) != 0 || (Int64((_la - 64)) & ~0x3f) == 0 && ((Int64(1) << (_la - 64)) & 4611686018427387903) != 0)

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class Non_close_parenContext: ParserRuleContext {
			open
			func CloseParen() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CloseParen.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_non_close_paren
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterNon_close_paren(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitNon_close_paren(self)
			}
		}
	}
	@discardableResult
	 open func non_close_paren() throws -> Non_close_parenContext {
		var _localctx: Non_close_parenContext
		_localctx = Non_close_parenContext(_ctx, getState())
		try enterRule(_localctx, 70, PCREParser.RULE_non_close_paren)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(943)
		 	_la = try _input.LA(1)
		 	if (_la <= 0 || (_la == PCREParser.Tokens.CloseParen.rawValue)) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	public class LetterContext: ParserRuleContext {
			open
			func ALC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ALC.rawValue, 0)
			}
			open
			func BLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.BLC.rawValue, 0)
			}
			open
			func CLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CLC.rawValue, 0)
			}
			open
			func DLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.DLC.rawValue, 0)
			}
			open
			func ELC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ELC.rawValue, 0)
			}
			open
			func FLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FLC.rawValue, 0)
			}
			open
			func GLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GLC.rawValue, 0)
			}
			open
			func HLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.HLC.rawValue, 0)
			}
			open
			func ILC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ILC.rawValue, 0)
			}
			open
			func JLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.JLC.rawValue, 0)
			}
			open
			func KLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.KLC.rawValue, 0)
			}
			open
			func LLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LLC.rawValue, 0)
			}
			open
			func MLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.MLC.rawValue, 0)
			}
			open
			func NLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NLC.rawValue, 0)
			}
			open
			func OLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OLC.rawValue, 0)
			}
			open
			func PLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PLC.rawValue, 0)
			}
			open
			func QLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QLC.rawValue, 0)
			}
			open
			func RLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RLC.rawValue, 0)
			}
			open
			func SLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SLC.rawValue, 0)
			}
			open
			func TLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.TLC.rawValue, 0)
			}
			open
			func ULC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ULC.rawValue, 0)
			}
			open
			func VLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.VLC.rawValue, 0)
			}
			open
			func WLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WLC.rawValue, 0)
			}
			open
			func XLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.XLC.rawValue, 0)
			}
			open
			func YLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.YLC.rawValue, 0)
			}
			open
			func ZLC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ZLC.rawValue, 0)
			}
			open
			func AUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.AUC.rawValue, 0)
			}
			open
			func BUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.BUC.rawValue, 0)
			}
			open
			func CUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.CUC.rawValue, 0)
			}
			open
			func DUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.DUC.rawValue, 0)
			}
			open
			func EUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.EUC.rawValue, 0)
			}
			open
			func FUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.FUC.rawValue, 0)
			}
			open
			func GUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.GUC.rawValue, 0)
			}
			open
			func HUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.HUC.rawValue, 0)
			}
			open
			func IUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.IUC.rawValue, 0)
			}
			open
			func JUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.JUC.rawValue, 0)
			}
			open
			func KUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.KUC.rawValue, 0)
			}
			open
			func LUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.LUC.rawValue, 0)
			}
			open
			func MUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.MUC.rawValue, 0)
			}
			open
			func NUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.NUC.rawValue, 0)
			}
			open
			func OUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.OUC.rawValue, 0)
			}
			open
			func PUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.PUC.rawValue, 0)
			}
			open
			func QUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.QUC.rawValue, 0)
			}
			open
			func RUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.RUC.rawValue, 0)
			}
			open
			func SUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.SUC.rawValue, 0)
			}
			open
			func TUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.TUC.rawValue, 0)
			}
			open
			func UUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.UUC.rawValue, 0)
			}
			open
			func VUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.VUC.rawValue, 0)
			}
			open
			func WUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.WUC.rawValue, 0)
			}
			open
			func XUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.XUC.rawValue, 0)
			}
			open
			func YUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.YUC.rawValue, 0)
			}
			open
			func ZUC() -> TerminalNode? {
				return getToken(PCREParser.Tokens.ZUC.rawValue, 0)
			}
		override open
		func getRuleIndex() -> Int {
			return PCREParser.RULE_letter
		}
		override open
		func enterRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.enterLetter(self)
			}
		}
		override open
		func exitRule(_ listener: ParseTreeListener) {
			if let listener = listener as? PCREListener {
				listener.exitLetter(self)
			}
		}
	}
	@discardableResult
	 open func letter() throws -> LetterContext {
		var _localctx: LetterContext
		_localctx = LetterContext(_ctx, getState())
		try enterRule(_localctx, 72, PCREParser.RULE_letter)
		var _la: Int = 0
		defer {
	    		try! exitRule()
	    }
		do {
		 	try enterOuterAlt(_localctx, 1)
		 	setState(945)
		 	_la = try _input.LA(1)
		 	if (!((Int64((_la - 63)) & ~0x3f) == 0 && ((Int64(1) << (_la - 63)) & 4503599627370495) != 0)) {
		 	try _errHandler.recoverInline(self)
		 	}
		 	else {
		 		_errHandler.reportMatch(self)
		 		try consume()
		 	}

		}
		catch ANTLRException.recognition(let re) {
			_localctx.exception = re
			_errHandler.reportError(self, re)
			try _errHandler.recover(self, re)
		}

		return _localctx
	}

	static let _serializedATN:[Int] = [
		4,1,125,948,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,6,2,
		7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,2,14,7,14,
		2,15,7,15,2,16,7,16,2,17,7,17,2,18,7,18,2,19,7,19,2,20,7,20,2,21,7,21,
		2,22,7,22,2,23,7,23,2,24,7,24,2,25,7,25,2,26,7,26,2,27,7,27,2,28,7,28,
		2,29,7,29,2,30,7,30,2,31,7,31,2,32,7,32,2,33,7,33,2,34,7,34,2,35,7,35,
		2,36,7,36,1,0,1,0,1,0,1,1,1,1,1,1,5,1,81,8,1,10,1,12,1,84,9,1,1,2,5,2,
		87,8,2,10,2,12,2,90,9,2,1,3,1,3,3,3,94,8,3,1,4,1,4,1,4,1,4,1,4,1,4,1,4,
		1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,1,4,3,
		4,120,8,4,1,5,1,5,1,5,3,5,125,8,5,1,6,1,6,1,6,1,6,1,6,4,6,132,8,6,11,6,
		12,6,133,1,6,1,6,1,6,1,6,1,6,1,6,5,6,142,8,6,10,6,12,6,145,9,6,1,6,1,6,
		1,6,1,6,4,6,151,8,6,11,6,12,6,152,1,6,1,6,1,6,1,6,1,6,1,6,4,6,161,8,6,
		11,6,12,6,162,1,6,1,6,1,6,1,6,1,6,5,6,170,8,6,10,6,12,6,173,9,6,1,6,1,
		6,1,6,4,6,178,8,6,11,6,12,6,179,1,6,1,6,3,6,184,8,6,1,7,1,7,1,7,1,7,1,
		7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,
		1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,7,1,
		7,1,7,3,7,227,8,7,1,8,1,8,1,8,3,8,232,8,8,1,9,1,9,1,9,1,9,1,9,1,9,1,9,
		1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,9,1,
		9,1,9,1,9,1,9,1,9,3,9,263,8,9,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,
		1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,
		1,10,1,10,1,10,3,10,290,8,10,1,11,1,11,1,11,1,11,1,11,1,11,1,12,1,12,1,
		12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,
		12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,
		12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,
		12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,1,12,3,12,352,8,12,1,13,4,13,
		355,8,13,11,13,12,13,356,1,14,1,14,1,15,1,15,1,15,1,15,1,15,1,15,1,15,
		1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,1,15,
		1,15,1,15,1,15,1,15,1,15,3,15,387,8,15,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,16,1,
		16,1,16,3,16,467,8,16,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,477,
		8,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,490,8,
		17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,503,8,17,
		1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,517,8,
		17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,531,
		8,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,544,8,
		17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,556,8,17,1,17,
		1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,3,17,570,8,17,1,
		17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,
		17,3,17,587,8,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,
		1,17,1,17,1,17,1,17,3,17,604,8,17,1,17,1,17,1,17,1,17,1,17,1,17,1,17,1,
		17,1,17,1,17,3,17,616,8,17,1,17,1,17,3,17,620,8,17,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,3,18,637,8,18,1,
		18,1,18,1,18,1,18,1,18,1,18,1,18,3,18,646,8,18,1,18,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,
		1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,1,18,3,18,
		722,8,18,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,
		19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,
		19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,
		19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,19,1,
		19,1,19,1,19,1,19,1,19,1,19,1,19,3,19,785,8,19,1,20,1,20,1,20,1,20,1,20,
		1,20,1,20,1,20,1,20,1,20,3,20,797,8,20,1,21,1,21,1,21,1,21,1,21,1,21,1,
		21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,21,1,
		21,1,21,1,21,1,21,1,21,1,21,3,21,825,8,21,1,22,1,22,1,22,1,22,1,22,1,22,
		1,22,3,22,834,8,22,1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,
		23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,1,23,3,23,855,8,23,1,24,1,24,3,24,
		859,8,24,1,25,1,25,1,25,1,25,1,25,1,25,1,25,1,25,1,25,1,25,1,25,1,25,3,
		25,873,8,25,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,
		1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,1,26,
		3,26,901,8,26,1,27,1,27,1,28,1,28,1,28,1,28,1,28,1,28,1,28,1,28,1,28,3,
		28,914,8,28,1,29,1,29,1,30,4,30,919,8,30,11,30,12,30,920,1,31,1,31,1,32,
		1,32,1,33,1,33,3,33,929,8,33,1,33,1,33,1,33,5,33,934,8,33,10,33,12,33,
		937,9,33,1,34,4,34,940,8,34,11,34,12,34,941,1,35,1,35,1,36,1,36,1,36,0,
		0,37,0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,
		48,50,52,54,56,58,60,62,64,66,68,70,72,0,6,6,0,71,71,75,75,81,81,86,86,
		98,98,109,109,2,0,115,117,124,124,2,0,115,121,124,124,1,0,115,124,1,0,
		53,53,1,0,63,114,1097,0,74,1,0,0,0,2,77,1,0,0,0,4,88,1,0,0,0,6,91,1,0,
		0,0,8,119,1,0,0,0,10,124,1,0,0,0,12,183,1,0,0,0,14,226,1,0,0,0,16,231,
		1,0,0,0,18,262,1,0,0,0,20,289,1,0,0,0,22,291,1,0,0,0,24,351,1,0,0,0,26,
		354,1,0,0,0,28,358,1,0,0,0,30,386,1,0,0,0,32,466,1,0,0,0,34,619,1,0,0,
		0,36,721,1,0,0,0,38,784,1,0,0,0,40,796,1,0,0,0,42,824,1,0,0,0,44,833,1,
		0,0,0,46,854,1,0,0,0,48,858,1,0,0,0,50,872,1,0,0,0,52,900,1,0,0,0,54,902,
		1,0,0,0,56,913,1,0,0,0,58,915,1,0,0,0,60,918,1,0,0,0,62,922,1,0,0,0,64,
		924,1,0,0,0,66,928,1,0,0,0,68,939,1,0,0,0,70,943,1,0,0,0,72,945,1,0,0,
		0,74,75,3,2,1,0,75,76,5,0,0,1,76,1,1,0,0,0,77,82,3,4,2,0,78,79,5,51,0,
		0,79,81,3,4,2,0,80,78,1,0,0,0,81,84,1,0,0,0,82,80,1,0,0,0,82,83,1,0,0,
		0,83,3,1,0,0,0,84,82,1,0,0,0,85,87,3,6,3,0,86,85,1,0,0,0,87,90,1,0,0,0,
		88,86,1,0,0,0,88,89,1,0,0,0,89,5,1,0,0,0,90,88,1,0,0,0,91,93,3,42,21,0,
		92,94,3,8,4,0,93,92,1,0,0,0,93,94,1,0,0,0,94,7,1,0,0,0,95,96,5,35,0,0,
		96,120,3,10,5,0,97,98,5,36,0,0,98,120,3,10,5,0,99,100,5,37,0,0,100,120,
		3,10,5,0,101,102,5,38,0,0,102,103,3,54,27,0,103,104,5,39,0,0,104,105,3,
		10,5,0,105,120,1,0,0,0,106,107,5,38,0,0,107,108,3,54,27,0,108,109,5,40,
		0,0,109,110,5,39,0,0,110,111,3,10,5,0,111,120,1,0,0,0,112,113,5,38,0,0,
		113,114,3,54,27,0,114,115,5,40,0,0,115,116,3,54,27,0,116,117,5,39,0,0,
		117,118,3,10,5,0,118,120,1,0,0,0,119,95,1,0,0,0,119,97,1,0,0,0,119,99,
		1,0,0,0,119,101,1,0,0,0,119,106,1,0,0,0,119,112,1,0,0,0,120,9,1,0,0,0,
		121,125,5,36,0,0,122,125,5,35,0,0,123,125,1,0,0,0,124,121,1,0,0,0,124,
		122,1,0,0,0,124,123,1,0,0,0,125,11,1,0,0,0,126,127,5,29,0,0,127,128,5,
		31,0,0,128,129,5,30,0,0,129,131,5,32,0,0,130,132,3,44,22,0,131,130,1,0,
		0,0,132,133,1,0,0,0,133,131,1,0,0,0,133,134,1,0,0,0,134,135,1,0,0,0,135,
		136,5,30,0,0,136,184,1,0,0,0,137,138,5,29,0,0,138,139,5,31,0,0,139,143,
		5,30,0,0,140,142,3,44,22,0,141,140,1,0,0,0,142,145,1,0,0,0,143,141,1,0,
		0,0,143,144,1,0,0,0,144,146,1,0,0,0,145,143,1,0,0,0,146,184,5,30,0,0,147,
		148,5,29,0,0,148,150,5,31,0,0,149,151,3,44,22,0,150,149,1,0,0,0,151,152,
		1,0,0,0,152,150,1,0,0,0,152,153,1,0,0,0,153,154,1,0,0,0,154,155,5,30,0,
		0,155,184,1,0,0,0,156,157,5,29,0,0,157,158,5,30,0,0,158,160,5,32,0,0,159,
		161,3,44,22,0,160,159,1,0,0,0,161,162,1,0,0,0,162,160,1,0,0,0,162,163,
		1,0,0,0,163,164,1,0,0,0,164,165,5,30,0,0,165,184,1,0,0,0,166,167,5,29,
		0,0,167,171,5,30,0,0,168,170,3,44,22,0,169,168,1,0,0,0,170,173,1,0,0,0,
		171,169,1,0,0,0,171,172,1,0,0,0,172,174,1,0,0,0,173,171,1,0,0,0,174,184,
		5,30,0,0,175,177,5,29,0,0,176,178,3,44,22,0,177,176,1,0,0,0,178,179,1,
		0,0,0,179,177,1,0,0,0,179,180,1,0,0,0,180,181,1,0,0,0,181,182,5,30,0,0,
		182,184,1,0,0,0,183,126,1,0,0,0,183,137,1,0,0,0,183,147,1,0,0,0,183,156,
		1,0,0,0,183,166,1,0,0,0,183,175,1,0,0,0,184,13,1,0,0,0,185,227,3,16,8,
		0,186,187,5,49,0,0,187,227,3,54,27,0,188,189,5,49,0,0,189,190,5,38,0,0,
		190,191,3,54,27,0,191,192,5,39,0,0,192,227,1,0,0,0,193,194,5,49,0,0,194,
		195,5,38,0,0,195,196,5,32,0,0,196,197,3,54,27,0,197,198,5,39,0,0,198,227,
		1,0,0,0,199,200,5,50,0,0,200,201,5,54,0,0,201,202,3,64,32,0,202,203,5,
		55,0,0,203,227,1,0,0,0,204,205,5,50,0,0,205,206,5,56,0,0,206,207,3,64,
		32,0,207,208,5,56,0,0,208,227,1,0,0,0,209,210,5,49,0,0,210,211,5,38,0,
		0,211,212,3,64,32,0,212,213,5,39,0,0,213,227,1,0,0,0,214,215,5,50,0,0,
		215,216,5,38,0,0,216,217,3,64,32,0,217,218,5,39,0,0,218,227,1,0,0,0,219,
		220,5,52,0,0,220,221,5,35,0,0,221,222,5,104,0,0,222,223,5,60,0,0,223,224,
		3,64,32,0,224,225,5,53,0,0,225,227,1,0,0,0,226,185,1,0,0,0,226,186,1,0,
		0,0,226,188,1,0,0,0,226,193,1,0,0,0,226,199,1,0,0,0,226,204,1,0,0,0,226,
		209,1,0,0,0,226,214,1,0,0,0,226,219,1,0,0,0,227,15,1,0,0,0,228,232,3,56,
		28,0,229,230,5,10,0,0,230,232,3,62,31,0,231,228,1,0,0,0,231,229,1,0,0,
		0,232,17,1,0,0,0,233,234,5,52,0,0,234,235,5,35,0,0,235,236,5,54,0,0,236,
		237,3,64,32,0,237,238,5,55,0,0,238,239,3,2,1,0,239,240,5,53,0,0,240,263,
		1,0,0,0,241,242,5,52,0,0,242,243,5,35,0,0,243,244,5,56,0,0,244,245,3,64,
		32,0,245,246,5,56,0,0,246,247,3,2,1,0,247,248,5,53,0,0,248,263,1,0,0,0,
		249,250,5,52,0,0,250,251,5,35,0,0,251,252,5,104,0,0,252,253,5,54,0,0,253,
		254,3,64,32,0,254,255,5,55,0,0,255,256,3,2,1,0,256,257,5,53,0,0,257,263,
		1,0,0,0,258,259,5,52,0,0,259,260,3,2,1,0,260,261,5,53,0,0,261,263,1,0,
		0,0,262,233,1,0,0,0,262,241,1,0,0,0,262,249,1,0,0,0,262,258,1,0,0,0,263,
		19,1,0,0,0,264,265,5,52,0,0,265,266,5,35,0,0,266,267,5,58,0,0,267,268,
		3,2,1,0,268,269,5,53,0,0,269,290,1,0,0,0,270,271,5,52,0,0,271,272,5,35,
		0,0,272,273,5,51,0,0,273,274,3,2,1,0,274,275,5,53,0,0,275,290,1,0,0,0,
		276,277,5,52,0,0,277,278,5,35,0,0,278,279,5,55,0,0,279,280,3,2,1,0,280,
		281,5,53,0,0,281,290,1,0,0,0,282,283,5,52,0,0,283,284,5,35,0,0,284,285,
		3,26,13,0,285,286,5,58,0,0,286,287,3,2,1,0,287,288,5,53,0,0,288,290,1,
		0,0,0,289,264,1,0,0,0,289,270,1,0,0,0,289,276,1,0,0,0,289,282,1,0,0,0,
		290,21,1,0,0,0,291,292,5,52,0,0,292,293,5,35,0,0,293,294,5,59,0,0,294,
		295,3,68,34,0,295,296,5,53,0,0,296,23,1,0,0,0,297,298,5,52,0,0,298,299,
		5,35,0,0,299,300,3,26,13,0,300,301,5,32,0,0,301,302,3,26,13,0,302,303,
		5,53,0,0,303,352,1,0,0,0,304,305,5,52,0,0,305,306,5,35,0,0,306,307,3,26,
		13,0,307,308,5,53,0,0,308,352,1,0,0,0,309,310,5,52,0,0,310,311,5,35,0,
		0,311,312,5,32,0,0,312,313,3,26,13,0,313,314,5,53,0,0,314,352,1,0,0,0,
		315,316,5,52,0,0,316,317,5,37,0,0,317,318,5,102,0,0,318,319,5,103,0,0,
		319,320,5,57,0,0,320,321,5,107,0,0,321,322,5,108,0,0,322,323,5,89,0,0,
		323,324,5,106,0,0,324,325,5,108,0,0,325,326,5,57,0,0,326,327,5,103,0,0,
		327,328,5,104,0,0,328,329,5,108,0,0,329,352,5,53,0,0,330,331,5,52,0,0,
		331,332,5,37,0,0,332,333,5,109,0,0,333,334,5,108,0,0,334,335,5,94,0,0,
		335,336,5,122,0,0,336,352,5,53,0,0,337,338,5,52,0,0,338,339,5,37,0,0,339,
		340,5,109,0,0,340,341,5,108,0,0,341,342,5,94,0,0,342,343,5,115,0,0,343,
		344,5,120,0,0,344,352,5,53,0,0,345,346,5,52,0,0,346,347,5,37,0,0,347,348,
		5,109,0,0,348,349,5,91,0,0,349,350,5,104,0,0,350,352,5,53,0,0,351,297,
		1,0,0,0,351,304,1,0,0,0,351,309,1,0,0,0,351,315,1,0,0,0,351,330,1,0,0,
		0,351,337,1,0,0,0,351,345,1,0,0,0,352,25,1,0,0,0,353,355,3,28,14,0,354,
		353,1,0,0,0,355,356,1,0,0,0,356,354,1,0,0,0,356,357,1,0,0,0,357,27,1,0,
		0,0,358,359,7,0,0,0,359,29,1,0,0,0,360,361,5,52,0,0,361,362,5,35,0,0,362,
		363,5,60,0,0,363,364,3,2,1,0,364,365,5,53,0,0,365,387,1,0,0,0,366,367,
		5,52,0,0,367,368,5,35,0,0,368,369,5,61,0,0,369,370,3,2,1,0,370,371,5,53,
		0,0,371,387,1,0,0,0,372,373,5,52,0,0,373,374,5,35,0,0,374,375,5,54,0,0,
		375,376,5,60,0,0,376,377,3,2,1,0,377,378,5,53,0,0,378,387,1,0,0,0,379,
		380,5,52,0,0,380,381,5,35,0,0,381,382,5,54,0,0,382,383,5,61,0,0,383,384,
		3,2,1,0,384,385,5,53,0,0,385,387,1,0,0,0,386,360,1,0,0,0,386,366,1,0,0,
		0,386,372,1,0,0,0,386,379,1,0,0,0,387,31,1,0,0,0,388,389,5,52,0,0,389,
		390,5,35,0,0,390,391,5,106,0,0,391,467,5,53,0,0,392,393,5,52,0,0,393,394,
		5,35,0,0,394,395,3,54,27,0,395,396,5,53,0,0,396,467,1,0,0,0,397,398,5,
		52,0,0,398,399,5,35,0,0,399,400,5,36,0,0,400,401,3,54,27,0,401,402,5,53,
		0,0,402,467,1,0,0,0,403,404,5,52,0,0,404,405,5,35,0,0,405,406,5,32,0,0,
		406,407,3,54,27,0,407,408,5,53,0,0,408,467,1,0,0,0,409,410,5,52,0,0,410,
		411,5,35,0,0,411,412,5,62,0,0,412,413,3,64,32,0,413,414,5,53,0,0,414,467,
		1,0,0,0,415,416,5,52,0,0,416,417,5,35,0,0,417,418,5,104,0,0,418,419,5,
		55,0,0,419,420,3,64,32,0,420,421,5,53,0,0,421,467,1,0,0,0,422,423,5,49,
		0,0,423,424,5,54,0,0,424,425,3,64,32,0,425,426,5,55,0,0,426,467,1,0,0,
		0,427,428,5,49,0,0,428,429,5,56,0,0,429,430,3,64,32,0,430,431,5,56,0,0,
		431,467,1,0,0,0,432,433,5,49,0,0,433,434,5,54,0,0,434,435,3,54,27,0,435,
		436,5,55,0,0,436,467,1,0,0,0,437,438,5,49,0,0,438,439,5,56,0,0,439,440,
		3,54,27,0,440,441,5,56,0,0,441,467,1,0,0,0,442,443,5,49,0,0,443,444,5,
		54,0,0,444,445,5,36,0,0,445,446,3,54,27,0,446,447,5,55,0,0,447,467,1,0,
		0,0,448,449,5,49,0,0,449,450,5,56,0,0,450,451,5,36,0,0,451,452,3,54,27,
		0,452,453,5,56,0,0,453,467,1,0,0,0,454,455,5,49,0,0,455,456,5,54,0,0,456,
		457,5,32,0,0,457,458,3,54,27,0,458,459,5,55,0,0,459,467,1,0,0,0,460,461,
		5,49,0,0,461,462,5,56,0,0,462,463,5,32,0,0,463,464,3,54,27,0,464,465,5,
		56,0,0,465,467,1,0,0,0,466,388,1,0,0,0,466,392,1,0,0,0,466,397,1,0,0,0,
		466,403,1,0,0,0,466,409,1,0,0,0,466,415,1,0,0,0,466,422,1,0,0,0,466,427,
		1,0,0,0,466,432,1,0,0,0,466,437,1,0,0,0,466,442,1,0,0,0,466,448,1,0,0,
		0,466,454,1,0,0,0,466,460,1,0,0,0,467,33,1,0,0,0,468,469,5,52,0,0,469,
		470,5,35,0,0,470,471,5,52,0,0,471,472,3,54,27,0,472,473,5,53,0,0,473,476,
		3,2,1,0,474,475,5,51,0,0,475,477,3,2,1,0,476,474,1,0,0,0,476,477,1,0,0,
		0,477,478,1,0,0,0,478,479,5,53,0,0,479,620,1,0,0,0,480,481,5,52,0,0,481,
		482,5,35,0,0,482,483,5,52,0,0,483,484,5,36,0,0,484,485,3,54,27,0,485,486,
		5,53,0,0,486,489,3,2,1,0,487,488,5,51,0,0,488,490,3,2,1,0,489,487,1,0,
		0,0,489,490,1,0,0,0,490,491,1,0,0,0,491,492,5,53,0,0,492,620,1,0,0,0,493,
		494,5,52,0,0,494,495,5,35,0,0,495,496,5,52,0,0,496,497,5,32,0,0,497,498,
		3,54,27,0,498,499,5,53,0,0,499,502,3,2,1,0,500,501,5,51,0,0,501,503,3,
		2,1,0,502,500,1,0,0,0,502,503,1,0,0,0,503,504,1,0,0,0,504,505,5,53,0,0,
		505,620,1,0,0,0,506,507,5,52,0,0,507,508,5,35,0,0,508,509,5,52,0,0,509,
		510,5,54,0,0,510,511,3,64,32,0,511,512,5,55,0,0,512,513,5,53,0,0,513,516,
		3,2,1,0,514,515,5,51,0,0,515,517,3,2,1,0,516,514,1,0,0,0,516,517,1,0,0,
		0,517,518,1,0,0,0,518,519,5,53,0,0,519,620,1,0,0,0,520,521,5,52,0,0,521,
		522,5,35,0,0,522,523,5,52,0,0,523,524,5,56,0,0,524,525,3,64,32,0,525,526,
		5,56,0,0,526,527,5,53,0,0,527,530,3,2,1,0,528,529,5,51,0,0,529,531,3,2,
		1,0,530,528,1,0,0,0,530,531,1,0,0,0,531,532,1,0,0,0,532,533,5,53,0,0,533,
		620,1,0,0,0,534,535,5,52,0,0,535,536,5,35,0,0,536,537,5,52,0,0,537,538,
		5,106,0,0,538,539,3,54,27,0,539,540,5,53,0,0,540,543,3,2,1,0,541,542,5,
		51,0,0,542,544,3,2,1,0,543,541,1,0,0,0,543,544,1,0,0,0,544,545,1,0,0,0,
		545,546,5,53,0,0,546,620,1,0,0,0,547,548,5,52,0,0,548,549,5,35,0,0,549,
		550,5,52,0,0,550,551,5,106,0,0,551,552,5,53,0,0,552,555,3,2,1,0,553,554,
		5,51,0,0,554,556,3,2,1,0,555,553,1,0,0,0,555,556,1,0,0,0,556,557,1,0,0,
		0,557,558,5,53,0,0,558,620,1,0,0,0,559,560,5,52,0,0,560,561,5,35,0,0,561,
		562,5,52,0,0,562,563,5,106,0,0,563,564,5,62,0,0,564,565,3,64,32,0,565,
		566,5,53,0,0,566,569,3,2,1,0,567,568,5,51,0,0,568,570,3,2,1,0,569,567,
		1,0,0,0,569,570,1,0,0,0,570,571,1,0,0,0,571,572,5,53,0,0,572,620,1,0,0,
		0,573,574,5,52,0,0,574,575,5,35,0,0,575,576,5,52,0,0,576,577,5,92,0,0,
		577,578,5,93,0,0,578,579,5,94,0,0,579,580,5,97,0,0,580,581,5,102,0,0,581,
		582,5,93,0,0,582,583,5,53,0,0,583,586,3,2,1,0,584,585,5,51,0,0,585,587,
		3,2,1,0,586,584,1,0,0,0,586,587,1,0,0,0,587,588,1,0,0,0,588,589,5,53,0,
		0,589,620,1,0,0,0,590,591,5,52,0,0,591,592,5,35,0,0,592,593,5,52,0,0,593,
		594,5,63,0,0,594,595,5,81,0,0,595,596,5,81,0,0,596,597,5,67,0,0,597,598,
		5,80,0,0,598,599,5,82,0,0,599,600,5,53,0,0,600,603,3,2,1,0,601,602,5,51,
		0,0,602,604,3,2,1,0,603,601,1,0,0,0,603,604,1,0,0,0,604,605,1,0,0,0,605,
		606,5,53,0,0,606,620,1,0,0,0,607,608,5,52,0,0,608,609,5,35,0,0,609,610,
		5,52,0,0,610,611,3,64,32,0,611,612,5,53,0,0,612,615,3,2,1,0,613,614,5,
		51,0,0,614,616,3,2,1,0,615,613,1,0,0,0,615,616,1,0,0,0,616,617,1,0,0,0,
		617,618,5,53,0,0,618,620,1,0,0,0,619,468,1,0,0,0,619,480,1,0,0,0,619,493,
		1,0,0,0,619,506,1,0,0,0,619,520,1,0,0,0,619,534,1,0,0,0,619,547,1,0,0,
		0,619,559,1,0,0,0,619,573,1,0,0,0,619,590,1,0,0,0,619,607,1,0,0,0,620,
		35,1,0,0,0,621,622,5,52,0,0,622,623,5,37,0,0,623,624,5,89,0,0,624,625,
		5,91,0,0,625,626,5,91,0,0,626,627,5,93,0,0,627,628,5,104,0,0,628,629,5,
		108,0,0,629,722,5,53,0,0,630,631,5,52,0,0,631,632,5,37,0,0,632,636,5,94,
		0,0,633,634,5,89,0,0,634,635,5,97,0,0,635,637,5,100,0,0,636,633,1,0,0,
		0,636,637,1,0,0,0,637,638,1,0,0,0,638,722,5,53,0,0,639,640,5,52,0,0,640,
		645,5,37,0,0,641,642,5,101,0,0,642,643,5,89,0,0,643,644,5,106,0,0,644,
		646,5,99,0,0,645,641,1,0,0,0,645,646,1,0,0,0,646,647,1,0,0,0,647,648,5,
		58,0,0,648,649,5,102,0,0,649,650,5,89,0,0,650,651,5,101,0,0,651,652,5,
		93,0,0,652,722,5,53,0,0,653,654,5,52,0,0,654,655,5,37,0,0,655,656,5,91,
		0,0,656,657,5,103,0,0,657,658,5,101,0,0,658,659,5,101,0,0,659,660,5,97,
		0,0,660,661,5,108,0,0,661,722,5,53,0,0,662,663,5,52,0,0,663,664,5,37,0,
		0,664,665,5,104,0,0,665,666,5,106,0,0,666,667,5,109,0,0,667,668,5,102,
		0,0,668,669,5,93,0,0,669,722,5,53,0,0,670,671,5,52,0,0,671,672,5,37,0,
		0,672,673,5,104,0,0,673,674,5,106,0,0,674,675,5,109,0,0,675,676,5,102,
		0,0,676,677,5,93,0,0,677,678,5,58,0,0,678,679,5,102,0,0,679,680,5,89,0,
		0,680,681,5,101,0,0,681,682,5,93,0,0,682,722,5,53,0,0,683,684,5,52,0,0,
		684,685,5,37,0,0,685,686,5,107,0,0,686,687,5,99,0,0,687,688,5,97,0,0,688,
		689,5,104,0,0,689,722,5,53,0,0,690,691,5,52,0,0,691,692,5,37,0,0,692,693,
		5,107,0,0,693,694,5,99,0,0,694,695,5,97,0,0,695,696,5,104,0,0,696,697,
		5,58,0,0,697,698,5,102,0,0,698,699,5,89,0,0,699,700,5,101,0,0,700,701,
		5,93,0,0,701,722,5,53,0,0,702,703,5,52,0,0,703,704,5,37,0,0,704,705,5,
		108,0,0,705,706,5,96,0,0,706,707,5,93,0,0,707,708,5,102,0,0,708,722,5,
		53,0,0,709,710,5,52,0,0,710,711,5,37,0,0,711,712,5,108,0,0,712,713,5,96,
		0,0,713,714,5,93,0,0,714,715,5,102,0,0,715,716,5,58,0,0,716,717,5,102,
		0,0,717,718,5,89,0,0,718,719,5,101,0,0,719,720,5,93,0,0,720,722,5,53,0,
		0,721,621,1,0,0,0,721,630,1,0,0,0,721,639,1,0,0,0,721,653,1,0,0,0,721,
		662,1,0,0,0,721,670,1,0,0,0,721,683,1,0,0,0,721,690,1,0,0,0,721,702,1,
		0,0,0,721,709,1,0,0,0,722,37,1,0,0,0,723,724,5,52,0,0,724,725,5,37,0,0,
		725,726,5,91,0,0,726,727,5,106,0,0,727,785,5,53,0,0,728,729,5,52,0,0,729,
		730,5,37,0,0,730,731,5,100,0,0,731,732,5,94,0,0,732,785,5,53,0,0,733,734,
		5,52,0,0,734,735,5,37,0,0,735,736,5,91,0,0,736,737,5,106,0,0,737,738,5,
		100,0,0,738,739,5,94,0,0,739,785,5,53,0,0,740,741,5,52,0,0,741,742,5,37,
		0,0,742,743,5,89,0,0,743,744,5,102,0,0,744,745,5,113,0,0,745,746,5,91,
		0,0,746,747,5,106,0,0,747,748,5,100,0,0,748,749,5,94,0,0,749,785,5,53,
		0,0,750,751,5,52,0,0,751,752,5,37,0,0,752,753,5,89,0,0,753,754,5,102,0,
		0,754,755,5,113,0,0,755,785,5,53,0,0,756,757,5,52,0,0,757,758,5,37,0,0,
		758,759,5,90,0,0,759,760,5,107,0,0,760,761,5,106,0,0,761,762,5,57,0,0,
		762,763,5,89,0,0,763,764,5,102,0,0,764,765,5,113,0,0,765,766,5,91,0,0,
		766,767,5,106,0,0,767,768,5,100,0,0,768,769,5,94,0,0,769,785,5,53,0,0,
		770,771,5,52,0,0,771,772,5,37,0,0,772,773,5,90,0,0,773,774,5,107,0,0,774,
		775,5,106,0,0,775,776,5,57,0,0,776,777,5,109,0,0,777,778,5,102,0,0,778,
		779,5,97,0,0,779,780,5,91,0,0,780,781,5,103,0,0,781,782,5,92,0,0,782,783,
		5,93,0,0,783,785,5,53,0,0,784,723,1,0,0,0,784,728,1,0,0,0,784,733,1,0,
		0,0,784,740,1,0,0,0,784,750,1,0,0,0,784,756,1,0,0,0,784,770,1,0,0,0,785,
		39,1,0,0,0,786,787,5,52,0,0,787,788,5,35,0,0,788,789,5,91,0,0,789,797,
		5,53,0,0,790,791,5,52,0,0,791,792,5,35,0,0,792,793,5,91,0,0,793,794,3,
		54,27,0,794,795,5,53,0,0,795,797,1,0,0,0,796,786,1,0,0,0,796,790,1,0,0,
		0,797,41,1,0,0,0,798,825,3,32,16,0,799,825,3,46,23,0,800,825,3,48,24,0,
		801,825,3,12,6,0,802,825,3,18,9,0,803,825,3,20,10,0,804,825,3,22,11,0,
		805,825,3,24,12,0,806,825,3,30,15,0,807,825,3,14,7,0,808,825,3,34,17,0,
		809,825,3,36,18,0,810,825,3,38,19,0,811,825,3,40,20,0,812,825,5,12,0,0,
		813,825,5,31,0,0,814,825,5,43,0,0,815,825,5,41,0,0,816,825,5,42,0,0,817,
		825,5,44,0,0,818,825,5,45,0,0,819,825,5,46,0,0,820,825,5,47,0,0,821,825,
		5,48,0,0,822,825,5,13,0,0,823,825,5,28,0,0,824,798,1,0,0,0,824,799,1,0,
		0,0,824,800,1,0,0,0,824,801,1,0,0,0,824,802,1,0,0,0,824,803,1,0,0,0,824,
		804,1,0,0,0,824,805,1,0,0,0,824,806,1,0,0,0,824,807,1,0,0,0,824,808,1,
		0,0,0,824,809,1,0,0,0,824,810,1,0,0,0,824,811,1,0,0,0,824,812,1,0,0,0,
		824,813,1,0,0,0,824,814,1,0,0,0,824,815,1,0,0,0,824,816,1,0,0,0,824,817,
		1,0,0,0,824,818,1,0,0,0,824,819,1,0,0,0,824,820,1,0,0,0,824,821,1,0,0,
		0,824,822,1,0,0,0,824,823,1,0,0,0,825,43,1,0,0,0,826,827,3,50,25,0,827,
		828,5,32,0,0,828,829,3,50,25,0,829,834,1,0,0,0,830,834,3,46,23,0,831,834,
		3,50,25,0,832,834,3,16,8,0,833,826,1,0,0,0,833,830,1,0,0,0,833,831,1,0,
		0,0,833,832,1,0,0,0,834,45,1,0,0,0,835,855,5,33,0,0,836,855,5,34,0,0,837,
		855,5,4,0,0,838,855,5,14,0,0,839,855,5,15,0,0,840,855,5,16,0,0,841,855,
		5,17,0,0,842,855,5,18,0,0,843,855,5,19,0,0,844,855,5,20,0,0,845,855,5,
		21,0,0,846,855,5,22,0,0,847,855,5,23,0,0,848,855,5,24,0,0,849,855,5,25,
		0,0,850,855,5,26,0,0,851,855,5,27,0,0,852,853,5,10,0,0,853,855,9,0,0,0,
		854,835,1,0,0,0,854,836,1,0,0,0,854,837,1,0,0,0,854,838,1,0,0,0,854,839,
		1,0,0,0,854,840,1,0,0,0,854,841,1,0,0,0,854,842,1,0,0,0,854,843,1,0,0,
		0,854,844,1,0,0,0,854,845,1,0,0,0,854,846,1,0,0,0,854,847,1,0,0,0,854,
		848,1,0,0,0,854,849,1,0,0,0,854,850,1,0,0,0,854,851,1,0,0,0,854,852,1,
		0,0,0,855,47,1,0,0,0,856,859,3,52,26,0,857,859,5,30,0,0,858,856,1,0,0,
		0,858,857,1,0,0,0,859,49,1,0,0,0,860,873,3,52,26,0,861,873,5,12,0,0,862,
		873,5,29,0,0,863,873,5,31,0,0,864,873,5,35,0,0,865,873,5,36,0,0,866,873,
		5,37,0,0,867,873,5,41,0,0,868,873,5,44,0,0,869,873,5,51,0,0,870,873,5,
		52,0,0,871,873,5,53,0,0,872,860,1,0,0,0,872,861,1,0,0,0,872,862,1,0,0,
		0,872,863,1,0,0,0,872,864,1,0,0,0,872,865,1,0,0,0,872,866,1,0,0,0,872,
		867,1,0,0,0,872,868,1,0,0,0,872,869,1,0,0,0,872,870,1,0,0,0,872,871,1,
		0,0,0,873,51,1,0,0,0,874,901,3,56,28,0,875,901,3,72,36,0,876,901,3,62,
		31,0,877,901,5,3,0,0,878,901,5,5,0,0,879,901,5,6,0,0,880,901,5,7,0,0,881,
		901,5,8,0,0,882,901,5,9,0,0,883,901,5,11,0,0,884,901,5,1,0,0,885,901,5,
		2,0,0,886,901,5,38,0,0,887,901,5,39,0,0,888,901,5,40,0,0,889,901,5,32,
		0,0,890,901,5,54,0,0,891,901,5,55,0,0,892,901,5,56,0,0,893,901,5,57,0,
		0,894,901,5,58,0,0,895,901,5,59,0,0,896,901,5,60,0,0,897,901,5,61,0,0,
		898,901,5,62,0,0,899,901,5,125,0,0,900,874,1,0,0,0,900,875,1,0,0,0,900,
		876,1,0,0,0,900,877,1,0,0,0,900,878,1,0,0,0,900,879,1,0,0,0,900,880,1,
		0,0,0,900,881,1,0,0,0,900,882,1,0,0,0,900,883,1,0,0,0,900,884,1,0,0,0,
		900,885,1,0,0,0,900,886,1,0,0,0,900,887,1,0,0,0,900,888,1,0,0,0,900,889,
		1,0,0,0,900,890,1,0,0,0,900,891,1,0,0,0,900,892,1,0,0,0,900,893,1,0,0,
		0,900,894,1,0,0,0,900,895,1,0,0,0,900,896,1,0,0,0,900,897,1,0,0,0,900,
		898,1,0,0,0,900,899,1,0,0,0,901,53,1,0,0,0,902,903,3,60,30,0,903,55,1,
		0,0,0,904,905,5,10,0,0,905,906,7,1,0,0,906,907,3,58,29,0,907,908,3,58,
		29,0,908,914,1,0,0,0,909,910,5,10,0,0,910,911,3,58,29,0,911,912,3,58,29,
		0,912,914,1,0,0,0,913,904,1,0,0,0,913,909,1,0,0,0,914,57,1,0,0,0,915,916,
		7,2,0,0,916,59,1,0,0,0,917,919,3,62,31,0,918,917,1,0,0,0,919,920,1,0,0,
		0,920,918,1,0,0,0,920,921,1,0,0,0,921,61,1,0,0,0,922,923,7,3,0,0,923,63,
		1,0,0,0,924,925,3,66,33,0,925,65,1,0,0,0,926,929,3,72,36,0,927,929,5,57,
		0,0,928,926,1,0,0,0,928,927,1,0,0,0,929,935,1,0,0,0,930,934,3,72,36,0,
		931,934,5,57,0,0,932,934,3,62,31,0,933,930,1,0,0,0,933,931,1,0,0,0,933,
		932,1,0,0,0,934,937,1,0,0,0,935,933,1,0,0,0,935,936,1,0,0,0,936,67,1,0,
		0,0,937,935,1,0,0,0,938,940,3,70,35,0,939,938,1,0,0,0,940,941,1,0,0,0,
		941,939,1,0,0,0,941,942,1,0,0,0,942,69,1,0,0,0,943,944,8,4,0,0,944,71,
		1,0,0,0,945,946,7,5,0,0,946,73,1,0,0,0,49,82,88,93,119,124,133,143,152,
		162,171,179,183,226,231,262,289,351,356,386,466,476,489,502,516,530,543,
		555,569,586,603,615,619,636,645,721,784,796,824,833,854,858,872,900,913,
		920,928,933,935,941
	]

	public
	static let _ATN = try! ATNDeserializer().deserialize(_serializedATN)
}