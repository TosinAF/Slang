import Quick
import Nimble

class SLElseTableViewCellTest: QuickSpec {
    override func spec() {
        let cell = SLElseTableViewCell(style: .Default, reuseIdentifier: nil)
        let type = BlockType.Else

        describe("type") {
            it("is SLElse") {
                expect(cell.type) == type
            }
        }

        describe("typeLabel") {
            it("should not be visible") {
                expect(cell.typeLabel.alpha) == 0.0
            }
        }
    }
}



