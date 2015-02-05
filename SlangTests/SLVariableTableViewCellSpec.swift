import Quick
import Nimble

class SLVariableTableViewCellSpec: QuickSpec {
    override func spec() {

        let type = BlockType.SLVariable
        var cell = SLVariableTableViewCell(style: .Default, reuseIdentifier: nil)

        beforeEach {
            cell = SLVariableTableViewCell(style: .Default, reuseIdentifier: nil)
        }

        describe("type") {
            it("is SLVariable") {
                expect(cell.type) == BlockType.SLVariable
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
                    expect(cell.nameInfoLabel.alpha) == 0.0
                    expect(cell.valueInfoLabel.alpha) == 0.0
                }
            }

            describe("textFields") {
                it("should have placeholders") {
                    expect(cell.variableNameTextField.text.utf16Count) != 0
                    expect(cell.variableValueTextField.text.utf16Count) != 0
                }
            }
        }

        context("one or more of the textFields has been edited") {

            describe("infoLabels") {
                it("should be visible") {
                    cell.textFieldDidBeginEditing(cell.variableNameTextField)
                    expect(cell.nameInfoLabel.alpha) == 1.0
                    expect(cell.valueInfoLabel.alpha) == 1.0
                }
            }

            describe("textFields") {
                it("should have no whitespace after editing completed") {
                    cell.textFieldDidBeginEditing(cell.variableNameTextField)
                    cell.variableNameTextField.text = "  x  "
                    cell.textFieldDidEndEditing(cell.variableNameTextField)
                    expect(cell.variableNameTextField.text) == "x"
                }
            }

            describe("variableNameTextFieldEdited") {

                beforeEach {
                    cell.textFieldDidBeginEditing(cell.variableNameTextField)
                }

                it("should be empty") {
                    expect(cell.variableNameTextField.text.utf16Count) == 0
                }

                describe("variable value textField") {
                    it("should still have a placeholder") {
                        expect(cell.variableValueTextField.text.utf16Count) != 0
                    }
                }
            }

            describe("variableValueTextFieldEdited") {

                beforeEach {
                    cell.textFieldDidBeginEditing(cell.variableValueTextField)
                }

                it("should be empty") {
                    expect(cell.variableValueTextField.text.utf16Count) == 0
                }

                describe("variable name textField") {
                    it("should still have a placeholder") {
                        expect(cell.variableNameTextField.text.utf16Count) != 0
                    }
                }
            }
        }
    }
}
