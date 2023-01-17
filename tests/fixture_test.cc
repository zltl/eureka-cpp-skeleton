#include <gtest/gtest.h>

#include <queue>

using std::queue;

class QueueTest : public ::testing::Test {
 protected:
  void SetUp() override {
    // q0_ remains empty
    q1_.push(1);
    q2_.push(2);
    q2_.push(3);
  }

  // void TearDown() override {}

  queue<int> q0_;
  queue<int> q1_;
  queue<int> q2_;
};

TEST_F(QueueTest, IsEmptyInitially) {
  EXPECT_EQ(q0_.size(), 0UL);
  EXPECT_NO_THROW({ q0_.pop(); });
}

TEST_F(QueueTest, DequeueWorks) {
  EXPECT_EQ(q0_.size(), 0UL);

  auto n = q1_.front();
  q1_.pop();
  ASSERT_NE(n, 0);
  EXPECT_EQ(q1_.size(), 0UL);

  n = q2_.front();
  q2_.pop();
  ASSERT_NE(n, 0);
  EXPECT_EQ(n, 2);
  EXPECT_EQ(q2_.size(), 1UL);
}
