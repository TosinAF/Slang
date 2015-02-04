import Quick
import Nimble

class SLEndTableViewCellSpec: QuickSpec {
    
    override func spec() {
        let cell = SLEndTableViewCell(style: .Default, reuseIdentifier: nil)

        describe("type") {
            it("is SLEnd") {
                expect(cell.type) == BlockType.SLEnd
            }
        }

        describe("typeLabel") {
            it("should not be visible") {
                expect(cell.typeLabel.alpha) == 0.0
            }
        }
    }
}