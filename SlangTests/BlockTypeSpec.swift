import Quick
import Nimble

class BlockTypeSpec: QuickSpec {
    override func spec() {

        describe("BlockType") {

            it("has 7 possible types") {
                expect(BlockType.allTypes.count) == 7
            }

            describe("SLBlank") {

                let type = BlockType.Blank

                it("has an identifier") {
                    expect(type.identifier) == "blank"
                }

                it("has a title") {
                    expect(type.title) == "BLANK"
                }

                it("has a tableviewcell class") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLBlankColor()
                }
            }

            describe("SLVariable") {

                let type = BlockType.Variable

                it("has an identifier") {
                    expect(type.identifier) == "variable"
                }

                it("has a title") {
                    expect(type.title) == "VARIABLE"
                }

                it("has a tableviewcell class") {
                    let cell = SLVariableTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLVariableColor()
                }
            }

            describe("SLIf") {

                let type = BlockType.If

                it("has an identifier") {
                    expect(type.identifier) == "if"
                }

                it("has a title") {
                    expect(type.title) == "IF Statement"
                }

                it("has a tableviewcell class") {
                    let cell = SLIfTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLIfColor()
                }
            }

            describe("SLElse") {

                let type = BlockType.Else

                it("has an identifier") {
                    expect(type.identifier) == "else"
                }

                it("has a title") {
                    expect(type.title) == "ELSE"
                }

                it("has a tableviewcell class") {
                    let cell = SLElseTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLElseColor()
                }
            }

            describe("SLRepeat") {

                let type = BlockType.Repeat

                it("has an identifier") {
                    expect(type.identifier) == "repeat"
                }

                it("has a title") {
                    expect(type.title) == "REPEAT"
                }

                it("has a tableviewcell class") {
                    let cell = SLRepeatTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLRepeatColor()
                }
            }

            describe("SLEnd") {

                let type = BlockType.End

                it("has an identifier") {
                    expect(type.identifier) == "end"
                }

                it("has a title") {
                    expect(type.title) == "END"
                }

                it("has a tableviewcell class") {
                    let cell = SLEndTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLEndColor()
                }
            }

            describe("SLPrint") {

                let type = BlockType.Print

                it("has an identifier") {
                    expect(type.identifier) == "print"
                }

                it("has a title") {
                    expect(type.title) == "PRINT"
                }

                it("has a tableviewcell class") {
                    let cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.tableViewCellClass === cell.dynamicType).to(beTrue())
                }

                it("has a color") {
                    let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
                    expect(type.color) == UIColor.SLPrintColor()
                }
            }
        }
        
    }
}
