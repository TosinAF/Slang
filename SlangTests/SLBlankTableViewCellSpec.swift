import Quick
import Nimble

class SLBlankTableViewCellTest: QuickSpec {
    override func spec() {

        let cell = SLBlankTableViewCell(style: .Default, reuseIdentifier: nil)
        let type = BlockType.Blank

        describe("type") {
            it("is SLBlank") {
                expect(cell.type) == BlockType.Blank
            }
        }

        describe("typeLabel") {
            it("should not be visible") {
                expect(cell.typeLabel.alpha) == 0.0
            }

            it("text should be the same as that of it's enum") {
                expect(cell.typeLabel.text) == type.title
            }
        }
    }
}