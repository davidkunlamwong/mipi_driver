/*
 * j20.c - J20 board driver
 *
 * Copyright (c) 2015-2016, NVIDIA CORPORATION.  All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <linux/slab.h>
#include <linux/uaccess.h>
#include <linux/gpio.h>
#include <linux/module.h>

#include <linux/seq_file.h>
#include <linux/of.h>
#include <linux/of_device.h>
#include <linux/of_gpio.h>

#include <linux/i2c-dev.h>
#include <linux/fs.h>

//#include <media/v4l2-chip-ident.h>
#include <media/camera_common.h>
#include <media/soc_camera.h>
#include <dt-bindings/gpio/tegra186-gpio.h>
// ??? #include <dt-bindings/gpio/tegra-gpio.h>

static struct of_device_id j20_of_match[] = {
    { .compatible = "nvidia,j20", },
    { },
};

MODULE_DEVICE_TABLE(of, j20_of_match);

static int j20_probe(struct i2c_client *client,
             const struct i2c_device_id *id)
{
  struct device_node *np = client->dev.of_node;
  const struct of_device_id *match;
  int gpio;

//  pr_info("[J20]: Driver function: %s.\n", __func__);
  dev_err(&client->dev, "%s(): Probing J20 adapter...\n", __func__);

  match = of_match_device(j20_of_match, &client->dev);
  if (!match) {
//    pr_info("[J20]: Failed to find matching dt id\n");
    dev_err(&client->dev, "%s(): Failed to find matching dt id\n", __func__);
    return -1;
  }

  gpio = of_get_named_gpio(np, "reset-gpios", 0);
  if (gpio < 0) {
    dev_warn(&client->dev, "%s(): reset gpios not in DT\n", __func__);
  }
  else
  {
    gpio_set_value(gpio, 1);
    dev_info(&client->dev,"%s(): Enabling GPIO: %i.\n", __func__, gpio);
  }

  if (i2c_smbus_write_byte_data(client, 6, 0x3e) < 0)
    dev_err(&client->dev, "Failed writing to reg: %d val %d\n", 6, 0x3e);
  if (i2c_smbus_write_byte_data(client, 7, 0x33) < 0)
    dev_err(&client->dev, "Failed writing to reg: %d val %d\n", 7, 0x33);
  if (i2c_smbus_write_byte_data(client, 2, 0xfe) < 0)
    dev_err(&client->dev, "Failed writing to reg: %d val %d\n", 2, 0xfe);
  if (i2c_smbus_write_byte_data(client, 3, 0xff) < 0)
    dev_err(&client->dev, "Failed writing to reg: %d val %d\n", 3, 0xff);

//  pr_info("[J20]: Writing setup configuration.\n");
//  dev_info(&client->dev,"[J20]: Setup configuration OK %s/%s\n",__DATE__,__TIME__);
  dev_err(&client->dev,"%s(): Setup configuration OK\n", __func__);

  return 0;
}

static int
j20_remove(struct i2c_client *client)
{
  return 0;
}

static const struct i2c_device_id j20_id[] = {
  { "j20", 0 },
  { }
};

MODULE_DEVICE_TABLE(i2c, j20_id);

static struct i2c_driver j20_i2c_driver = {
  .driver = {
    .name = "j20",
    .owner = THIS_MODULE,
    .of_match_table = of_match_ptr(j20_of_match),
  },
  .probe = j20_probe,
  .remove = j20_remove,
  .id_table = j20_id,
};

module_i2c_driver(j20_i2c_driver);

MODULE_DESCRIPTION("Driver for J20 setup");
MODULE_AUTHOR("<support@ridgerun.com>");
MODULE_LICENSE("GPL v2");
