import Quick
import Nimble

class SLRepeatTableViewCellSpec: QuickSpec {
    
    override func spec() {

        let type = BlockType.Repeat
        var cell = SLRepeatTableViewCell(style: .Default, reuseIdentifier: "identifier")

        beforeEach {
            cell = SLRepeatTableViewCell(style: .Default, reuseIdentifier: "identifier")
        }

        describe("type") {
            it("is SLRepeat") {
                expect(cell.type) == BlockType.Repeat
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
                    cell.textFieldDidBeginEditing(cell.repeatCountTextField)
                    expect(cell.infoLabel.alpha) == 1.0
                }
            }
        }

        context("textField has finished editing") {
            describe("textField") {
                it("should have no whitespace after editing completed") {
                    cell.textFieldDidBeginEditing(cell.repeatCountTextField)
                    cell.repeatCountTextField.text = "  5  "
                    cell.textFieldDidEndEditing(cell.repeatCountTextField)
                    expect(cell.repeatCountTextField.text) == "5"
                }
            }
        }
    }
}
