// Generated from java-escape by ANTLR 4.11.1
import Antlr4

/**
 * This interface defines a complete listener for a parse tree produced by
 * {@link PCREParser}.
 */
public protocol PCREListener: ParseTreeListener {
	/**
	 * Enter a parse tree produced by {@link PCREParser#parse}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterParse(_ ctx: PCREParser.ParseContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#parse}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitParse(_ ctx: PCREParser.ParseContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#alternation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAlternation(_ ctx: PCREParser.AlternationContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#alternation}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAlternation(_ ctx: PCREParser.AlternationContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterExpr(_ ctx: PCREParser.ExprContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#expr}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitExpr(_ ctx: PCREParser.ExprContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#element}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterElement(_ ctx: PCREParser.ElementContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#element}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitElement(_ ctx: PCREParser.ElementContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#quantifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterQuantifier(_ ctx: PCREParser.QuantifierContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#quantifier}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitQuantifier(_ ctx: PCREParser.QuantifierContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#quantifier_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterQuantifier_type(_ ctx: PCREParser.Quantifier_typeContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#quantifier_type}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitQuantifier_type(_ ctx: PCREParser.Quantifier_typeContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#character_class}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCharacter_class(_ ctx: PCREParser.Character_classContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#character_class}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCharacter_class(_ ctx: PCREParser.Character_classContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#backreference}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBackreference(_ ctx: PCREParser.BackreferenceContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#backreference}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBackreference(_ ctx: PCREParser.BackreferenceContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#backreference_or_octal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBackreference_or_octal(_ ctx: PCREParser.Backreference_or_octalContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#backreference_or_octal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBackreference_or_octal(_ ctx: PCREParser.Backreference_or_octalContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#capture}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCapture(_ ctx: PCREParser.CaptureContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#capture}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCapture(_ ctx: PCREParser.CaptureContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#non_capture}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNon_capture(_ ctx: PCREParser.Non_captureContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#non_capture}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNon_capture(_ ctx: PCREParser.Non_captureContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#comment}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterComment(_ ctx: PCREParser.CommentContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#comment}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitComment(_ ctx: PCREParser.CommentContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#option}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOption(_ ctx: PCREParser.OptionContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#option}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOption(_ ctx: PCREParser.OptionContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#option_flags}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOption_flags(_ ctx: PCREParser.Option_flagsContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#option_flags}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOption_flags(_ ctx: PCREParser.Option_flagsContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#option_flag}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOption_flag(_ ctx: PCREParser.Option_flagContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#option_flag}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOption_flag(_ ctx: PCREParser.Option_flagContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#look_around}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLook_around(_ ctx: PCREParser.Look_aroundContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#look_around}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLook_around(_ ctx: PCREParser.Look_aroundContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#subroutine_reference}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterSubroutine_reference(_ ctx: PCREParser.Subroutine_referenceContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#subroutine_reference}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitSubroutine_reference(_ ctx: PCREParser.Subroutine_referenceContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterConditional(_ ctx: PCREParser.ConditionalContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#conditional}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitConditional(_ ctx: PCREParser.ConditionalContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#backtrack_control}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterBacktrack_control(_ ctx: PCREParser.Backtrack_controlContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#backtrack_control}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitBacktrack_control(_ ctx: PCREParser.Backtrack_controlContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#newline_convention}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNewline_convention(_ ctx: PCREParser.Newline_conventionContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#newline_convention}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNewline_convention(_ ctx: PCREParser.Newline_conventionContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#callout}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCallout(_ ctx: PCREParser.CalloutContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#callout}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCallout(_ ctx: PCREParser.CalloutContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAtom(_ ctx: PCREParser.AtomContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAtom(_ ctx: PCREParser.AtomContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#cc_atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCc_atom(_ ctx: PCREParser.Cc_atomContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#cc_atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCc_atom(_ ctx: PCREParser.Cc_atomContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#shared_atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterShared_atom(_ ctx: PCREParser.Shared_atomContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#shared_atom}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitShared_atom(_ ctx: PCREParser.Shared_atomContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLiteral(_ ctx: PCREParser.LiteralContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLiteral(_ ctx: PCREParser.LiteralContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#cc_literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterCc_literal(_ ctx: PCREParser.Cc_literalContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#cc_literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitCc_literal(_ ctx: PCREParser.Cc_literalContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#shared_literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterShared_literal(_ ctx: PCREParser.Shared_literalContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#shared_literal}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitShared_literal(_ ctx: PCREParser.Shared_literalContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#number}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNumber(_ ctx: PCREParser.NumberContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#number}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNumber(_ ctx: PCREParser.NumberContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#octal_char}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOctal_char(_ ctx: PCREParser.Octal_charContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#octal_char}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOctal_char(_ ctx: PCREParser.Octal_charContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#octal_digit}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterOctal_digit(_ ctx: PCREParser.Octal_digitContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#octal_digit}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitOctal_digit(_ ctx: PCREParser.Octal_digitContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#digits}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDigits(_ ctx: PCREParser.DigitsContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#digits}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDigits(_ ctx: PCREParser.DigitsContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#digit}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterDigit(_ ctx: PCREParser.DigitContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#digit}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitDigit(_ ctx: PCREParser.DigitContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterName(_ ctx: PCREParser.NameContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#name}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitName(_ ctx: PCREParser.NameContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#alpha_nums}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterAlpha_nums(_ ctx: PCREParser.Alpha_numsContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#alpha_nums}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitAlpha_nums(_ ctx: PCREParser.Alpha_numsContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#non_close_parens}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNon_close_parens(_ ctx: PCREParser.Non_close_parensContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#non_close_parens}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNon_close_parens(_ ctx: PCREParser.Non_close_parensContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#non_close_paren}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterNon_close_paren(_ ctx: PCREParser.Non_close_parenContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#non_close_paren}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitNon_close_paren(_ ctx: PCREParser.Non_close_parenContext)
	/**
	 * Enter a parse tree produced by {@link PCREParser#letter}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func enterLetter(_ ctx: PCREParser.LetterContext)
	/**
	 * Exit a parse tree produced by {@link PCREParser#letter}.
	 - Parameters:
	   - ctx: the parse tree
	 */
	func exitLetter(_ ctx: PCREParser.LetterContext)
}