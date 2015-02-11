import Quick
import Nimble

class SLIfTableViewCellSpec: QuickSpec {
    override func spec() {

        let type = BlockType.If
        var cell = SLIfTableViewCell(style: .Default, reuseIdentifier: "identifier")

        beforeEach {
            cell = SLIfTableViewCell(style: .Default, reuseIdentifier: "identifier")
        }

        describe("type") {
            it("is SLIf") {
                expect(cell.type) == type
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

        context("textFields havent yet been edited") {
            describe("infoLabels") {
                it("should not be visible") {
                    expect(cell.statementOneInfoLabel.alpha) == 0.0
                    expect(cell.statementTwoInfoLabel.alpha) == 0.0
                    expect(cell.conditionOperatorInfoLabel.alpha) == 0.0
                }
            }
        }

        context("one of the textFields has been edited") {

            describe("infoLabels") {
                it("should be visible") {
                    cell.textFieldDidBeginEditing(cell.statementOneTextField)
                    expect(cell.statementOneInfoLabel.alpha) == 1.0
                    expect(cell.statementTwoInfoLabel.alpha) == 1.0
                    expect(cell.conditionOperatorInfoLabel.alpha) == 1.0
                }
            }

            describe("textFields") {
                it("should have no whitespace after editing completed") {
                    cell.textFieldDidBeginEditing(cell.statementOneTextField)
                    cell.statementOneTextField.text = "  Hello  "
                    cell.textFieldDidEndEditing(cell.statementOneTextField)
                    expect(cell.statementOneTextField.text) == "Hello"
                }
            }
        }
    }
}
