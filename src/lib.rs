use std::{fmt::Display, mem};

use gibberish_tree::{
    lang::Lang,
    node::{Lexeme, LexemeData, Node},
    state::{State, StateData},
    vec::RawVec,
};

#[link(name = "gibberish-parser", kind = "static")]
unsafe extern "C" {
    fn lex(ptr: *const u8, len: usize) -> RawVec<LexemeData>;
    fn default_state_ptr(ptr: *const u8, len: usize) -> *const StateData;
    fn parse(ptr: *const StateData) -> u32;
    fn get_state(ptr: *const StateData) -> StateData;
    // fn token_name(id: u32) -> SliceData;
    // fn group_name(id: u32) -> SliceData;
}

use parse as p;

impl Display for Gibberish {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Gibberish")
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct Gibberish;

#[repr(u32)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum GibberishToken {
    Keyword,
    Parser,
    Token,
    Hightlight,
    Fold,
    Whitespace,
    Int,
    Colon,
    Comma,
    Bar,
    Dot,
    LBracket,
    RBracket,
    LParen,
    RParen,
    LBrace,
    RBrace,
    Plus,
    Eq,
    Ident,
    Semi,
    String,
    At,

    Err,
}

#[repr(u32)]
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub enum GibberishSyntax {
    Named = 1,
    CallName = 3,
    Args = 4,
    Call = 5,
    MemberCall = 6,
    Seq = 7,
    Choice = 8,
    KeywordDef = 9,
    TokenDef = 10,
    FoldStmt = 11,
    ParserDef = 12,
    ChildQuery = 14,
    GroupQuery = 15,
    Label = 16,
    LabelledQuery = 17,
    HighlightDef = 18,
    Root = 21,
}

impl Display for GibberishToken {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            GibberishToken::Keyword => write!(f, "Keyword"),
            GibberishToken::Parser => write!(f, "Parser"),
            GibberishToken::Token => write!(f, "Token"),
            GibberishToken::Hightlight => write!(f, "Hightlight"),
            GibberishToken::Fold => write!(f, "Fold"),
            GibberishToken::Whitespace => write!(f, "Whitespace"),
            GibberishToken::Int => write!(f, "Int"),
            GibberishToken::Colon => write!(f, "Colon"),
            GibberishToken::Comma => write!(f, "Comma"),
            GibberishToken::Bar => write!(f, "Bar"),
            GibberishToken::Dot => write!(f, "Dot"),
            GibberishToken::LBracket => write!(f, "LBracket"),
            GibberishToken::RBracket => write!(f, "RBracket"),
            GibberishToken::LParen => write!(f, "LParen"),
            GibberishToken::RParen => write!(f, "RParen"),
            GibberishToken::LBrace => write!(f, "LBrace"),
            GibberishToken::RBrace => write!(f, "RBrace"),
            GibberishToken::Plus => write!(f, "Plus"),
            GibberishToken::Eq => write!(f, "Eq"),
            GibberishToken::Ident => write!(f, "Ident"),
            GibberishToken::Semi => write!(f, "Semi"),
            GibberishToken::String => write!(f, "String"),
            GibberishToken::At => write!(f, "At"),
            GibberishToken::Err => write!(f, "Err"),
        }
    }
}

impl Display for GibberishSyntax {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        match self {
            GibberishSyntax::Named => write!(f, "Named"),
            GibberishSyntax::CallName => write!(f, "CallName"),
            GibberishSyntax::Call => write!(f, "Call"),
            GibberishSyntax::MemberCall => write!(f, "MemberCall"),
            GibberishSyntax::Seq => write!(f, "Seq"),
            GibberishSyntax::Choice => write!(f, "Choice"),
            GibberishSyntax::KeywordDef => write!(f, "KeywordDef"),
            GibberishSyntax::TokenDef => write!(f, "TokenDef"),
            GibberishSyntax::FoldStmt => write!(f, "FoldStmt"),
            GibberishSyntax::ParserDef => write!(f, "ParserDef"),
            GibberishSyntax::ChildQuery => write!(f, "ChildQuery"),
            GibberishSyntax::GroupQuery => write!(f, "GroupQuery"),
            GibberishSyntax::LabelledQuery => write!(f, "LabelledQuery"),
            GibberishSyntax::HighlightDef => write!(f, "HighlightDef"),
            GibberishSyntax::Args => write!(f, "Args"),
            GibberishSyntax::Label => write!(f, "Label"),
            GibberishSyntax::Root => write!(f, "Root"),
        }
    }
}

impl Lang for Gibberish {
    type Token = GibberishToken;
    type Syntax = GibberishSyntax;

    fn lex(&self, _: &str) -> Vec<Lexeme<Self>> {
        todo!()
    }

    fn root(&self) -> Self::Syntax {
        todo!()
    }
    //
    // fn token_name(&self, token: &Self::Token) -> String {
    //     let slice: &str = unsafe { token_name(mem::transmute(*token)) }.into();
    //     slice.to_string()
    // }
    //
    // fn syntax_name(&self, syntax: &Self::Syntax) -> String {
    //     let slice: &str = unsafe { group_name(mem::transmute(*syntax)) }.into();
    //     slice.to_string()
    // }
}

impl Gibberish {
    pub fn lex(text: &str) -> Vec<Lexeme<Gibberish>> {
        unsafe {
            Vec::from(lex(text.as_ptr(), text.len()))
                .into_iter()
                .map(|it| {
                    let temp = Lexeme::from_data(it, text);
                    mem::transmute(temp)
                })
                .collect()
        }
    }

    pub fn parse(text: &str) -> Node<Gibberish> {
        unsafe {
            let state_ptr = default_state_ptr(text.as_ptr(), text.len());
            p(state_ptr);
            let state_data = get_state(state_ptr);
            let mut state = State::from_data(state_data, text);
            assert_eq!(state.stack.len(), 1);
            mem::transmute(state.stack.pop().unwrap())
        }
    }
}
