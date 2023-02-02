
import eureka.log;

int main(int, char*[]) {
  eureka::log::conf()
      ->set_dir("./logs/xyz")
      ->set_dir_max_size(10L * 1024 * 1024 * 1024)
      ->apply();
  return 0;
}
