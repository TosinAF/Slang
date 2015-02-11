import Quick
import Nimble

class SLPrintTableViewCellSpec: QuickSpec {

    override func spec() {

        let type = BlockType.Print
        var cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: "identifier")

        beforeEach {
            cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: "identifier")
        }

        describe("type") {
            it("is SLPrint") {
                expect(cell.type) == BlockType.Print
            }
        }

        describe("typeLabel") {
            it("should be visible") {
                expect(cell.typeLabel.alpha) == 1.0
            }

            it("text should be the same as that of it's enum") {
                expect(cell.typeLabel.text) == type.title
            }
        }

        context("textField not yet edited") {
            describe("infoLabel") {
                it("should not be visible") {
                    expect(cell.infoLabel.alpha) == 0.0
                }
            }
        }

        context("textField has been edited") {
            describe("infoLabel") {
                it("should be visible") {
                    cell.textFieldDidBeginEditing(cell.printStatementTextField)
                    expect(cell.infoLabel.alpha) == 1.0
                }
            }
        }

        context("textField has finished editing") {
            describe("textField") {
                it("should have no whitespace after editing completed") {
                    cell.textFieldDidBeginEditing(cell.printStatementTextField)
                    cell.printStatementTextField.text = "  x  "
                    cell.textFieldDidEndEditing(cell.printStatementTextField)
                    expect(cell.printStatementTextField.text) == "x"
                }
            }
        }
    }
}
