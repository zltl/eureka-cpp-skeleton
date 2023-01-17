#include <gtest/gtest.h>
#include <gmock/gmock.h>

import turtle;

class MockTurtle : public Turtle {
 public:
  MOCK_METHOD(void, PenUp, (), (override));
  MOCK_METHOD(void, PenDown, (), (override));
  MOCK_METHOD(void, Forward, (int distance), (override));
  MOCK_METHOD(void, Turn, (int degrees), (override));
  MOCK_METHOD(void, GoTo, (int x, int y), (override));
  MOCK_METHOD(int, GetX, (), (const, override));
  MOCK_METHOD(int, GetY, (), (const, override));
};

using ::testing::AtLeast;                         // #1

TEST(PainterTest, CanDrawSomething) {
  MockTurtle turtle;                              // #2
  EXPECT_CALL(turtle, PenDown())                  // #3
      .Times(AtLeast(1));

  // Painter painter(&turtle);                       // #4
  turtle.PenDown();
  turtle.PenDown();
  // EXPECT_TRUE(painter.DrawCircle(0, 0, 10));      // #5
}
