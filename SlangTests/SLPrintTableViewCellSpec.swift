import Quick
import Nimble

class SLPrintTableViewCellSpec: QuickSpec {

    override func spec() {

        let type = BlockType.SLPrint
        var cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: "identifier")

        beforeEach {
            cell = SLPrintTableViewCell(style: .Default, reuseIdentifier: "identifier")
        }

        describe("type") {
            it("is SLPrint") {
                expect(cell.type) == BlockType.SLPrint
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
                    let cell2 = SLPrintTableViewCell(style: .Default, reuseIdentifier: "identifier")
                    expect(cell2.infoLabel.alpha) == 0.0
                }
            }

            describe("textField") {
                it("should have a placeholder") {
                    expect(cell.printStatementTextField.text.utf16Count) != 0
                }
            }
        }

        context("textField has been edited") {

            beforeEach {
                cell.textFieldDidBeginEditing(cell.printStatementTextField)
            }

            describe("infoLabel") {
                it("should be visible") {
                    expect(cell.infoLabel.alpha) == 1.0
                }
            }

            describe("textField") {
                it("should be empty") {
                    expect(cell.printStatementTextField.text.utf16Count) == 0
                }
            }
        }
    }
}
