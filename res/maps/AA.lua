return {
  version = "1.2",
  luaversion = "5.1",
  tiledversion = "1.3.1",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 50,
  height = 50,
  tilewidth = 16,
  tileheight = 16,
  nextlayerid = 5,
  nextobjectid = 22,
  properties = {},
  tilesets = {
    {
      name = "mainlevbuild",
      firstgid = 1,
      filename = "tilesets/PFS1/mainlevbuild.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 64,
      image = "tilesets/PFS1/mainlevbuild.png",
      imagewidth = 1024,
      imageheight = 1024,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 4096,
      tiles = {}
    },
    {
      name = "decorative_obj",
      firstgid = 4097,
      filename = "tilesets/PFS1/decorative_obj.tsx",
      tilewidth = 16,
      tileheight = 16,
      spacing = 0,
      margin = 0,
      columns = 64,
      image = "tilesets/PFS1/decorative_obj.png",
      imagewidth = 1024,
      imageheight = 576,
      tileoffset = {
        x = 0,
        y = 0
      },
      grid = {
        orientation = "orthogonal",
        width = 16,
        height = 16
      },
      properties = {},
      terrains = {},
      tilecount = 2304,
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      id = 2,
      name = "Decoration",
      x = 0,
      y = 0,
      width = 50,
      height = 50,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAHtk8sNgkAURSeuUNlrLX63KhSgHWgLKrgFtQDtQGvQAvx1pAuPC3aQyI6Z3JecTMI8yLtnBmNUMiAD/xpY0biGCOJ/X1KfDMhA5Q14LWPq0IAm+GBjjZh7DBMIIAQbK2HuFLawgz3YWDfmvsMDnvACG8tr839AA5rgg401Yu4xTCCAEGyshLlT2MIO9uBKTckycyDPgQxHB3K4cK8uhLg6EORNhk+JHHPu36KCd7DseZzIcIZuzZge9GEAQ8h7lu391k5BTwmNha1lzyP70IqZ1hBBDBvIe5bt/dZlQU/2Ta0yIAMyIAMyIAMyIAMyIAMyIAMyIAMyIAMyIAMyIAP5Br7d7yuB"
    },
    {
      type = "tilelayer",
      id = 1,
      name = "Platform",
      x = 0,
      y = 0,
      width = 50,
      height = 50,
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      properties = {},
      encoding = "base64",
      compression = "zlib",
      data = "eAHt2tluG1Ucx/FJUiCxsydctwn7W0TtBfHSrEWiFKm1y/oa7U0Wk70tLUvrKes7sEhwUSfOnggkupEEKLwD2/cn5l+djuy2ESH2oB7po3PmzHj8/885Mz6a5LDneUcwiCEchf8AWfabfHDsB9QfYi/LCU72KjLQ9/n1nnf5Mb4HW7RVZ6nVf4b9ZzGNGSiPPvglKM/hUL/13aT/FvayvMfJ3oeuleJWzPnALXKQq2zv4BuO+RZrWEcvEkgG3G3lMFv7z7ipnYXl8XKN5x3HXpbrnOwGNB6KVbko7gw0LurTttq1fHcd2tCOJSxjhM+OYgzjsPGyuK2eZd8c3uUzF7GXxR0PXXvNI80hjYlyUb2N2/Qf5ruPON/fxPVuRoGA5rGAIkqNV4r+DWzivyjueGjsTxPzFjQGNsc0Fhn2nSGHs04e5eKx8RrhAHecOvhs50N8vtx579d/np0XMAiNv669aD750JioVt9uS4EPuOO028/v5vjvOPh72JzO0NZYKHaNjeaVttWOQrE5beOSJ2gfGocdZCOSh81pd1x0v2h8rKYZmWLjkiBi/S7oOZOGfvOiVGxc7Dljvwm5KCXhxGrPGftNWHT2RbEZ43kfRyOiXJLEn0I64nmMEf84cmg/4HkdsLqv1vP6MYBqL+68GiKHYVg9QfyTmIpAHu68miGHWUxD7WXiX8FqYI16HRvYRDUVd17Nx1nTohhorvO8FrQG2qjb0YFOVFNx51VDo+fFEA/0EWs/Bqos5lLXz51XCeJPQmtgrbcmiH8SUxHIw51XyiEFrYG1Hl4m/hWshvJYjN17RdZ41q3jFY77lPvmM3weun++YP+X+ApfI1zK7f+I83yMT1Du3NfYV0ARi0g/7nmaW1vkoHVwM/d6C1oDbdTt0LP5njafbccl8rhD/St+g1t+J/Y/8Cf+KpFHuf0/cZ6f8QvKnfsJvrcecTRCeSw3eV5Xg+d1o494+zEQGKS2Z7LbPk7/D3z+DvFdp76Bm9iL8jTneQbP4jk8jxfglhfZ7kUKaeTIQ5RLhgOzmCTGqcA0tT2bz9E+jwu4iEvQe5Mtctkucb3d791N+zXieh1v4E28hbdRqozTn8MiOZg8B/pYom+GMdU7HlHbcswGx/jU9q6ki/3dqEQpKgcoroflc6xkuPZZ2LuSTC3bqESx8bDYrHave5bAXHm2dVyeHHzYu5J8LduoRCk3Hhar4g2zfXY/XCF2y6FS42HXLhyrbWc5wKV75CAOoZL3g8Udrn06wuy6u/2630/iFCp5P4Tjt+0sjftR/HMBdy1s6+B19m0EKrke9kuMh9s3TYyaU8rFXQvbOtjWwpVeD2ceMB5Z9isPjYu7Fh7kmT2EYRxDpUupe8EnKJfNLXctPE3sM5jFXBXkYTHa3NE8Up9ql/rctfAasa9jA5tVkIfit3tAtd3TJ2r42xz0vp4ceujvcf/m9CRrymoqvQSTgL0vvXzA67mCPHxcxTA5HIP7N6eXqiyPEXIYhb0rPUncp5BBFqfRQQ6d4LC75VyV5VEgsnnYu9KDxH0IXejGU9io8Xo2cTeJCDRu13k9P2IL29hB1HKIwGV+FOKjK/C/vQLLvANbwSrWEOddbCOa0Iz9Lkn+hyCFNK4RTwHzWEAReme3hHDcirUFrWhDCmkcRR/2u4wR/zhyUDz1aEAM4Wvsxq1Y+zGAQYwjh3cwgf0uC8RfxCJ6+X5JIInwNXbjHmH/KKweo13Pe7MGxLDfJcb7rTgaoZgsLqsVn7j7tF2A/k5h9QLtXuJPIPkv8/gbbtKYzw=="
    },
    {
      type = "objectgroup",
      id = 3,
      name = "Bounds",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 1,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 352,
          width = 48,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 2,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 368,
          width = 128,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 3,
          name = "",
          type = "",
          shape = "rectangle",
          x = 80,
          y = 272,
          width = 16,
          height = 112,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "",
          type = "",
          shape = "rectangle",
          x = 0,
          y = 256,
          width = 96,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "",
          type = "",
          shape = "rectangle",
          x = 96,
          y = 288,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "",
          type = "",
          shape = "rectangle",
          x = 384,
          y = 352,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 352,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "",
          type = "",
          shape = "rectangle",
          x = 608,
          y = 352,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "",
          type = "",
          shape = "rectangle",
          x = 752,
          y = 352,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 10,
          name = "",
          type = "",
          shape = "rectangle",
          x = 784,
          y = 176,
          width = 16,
          height = 272,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "",
          type = "",
          shape = "rectangle",
          x = 480,
          y = 736,
          width = 80,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 12,
          name = "",
          type = "",
          shape = "rectangle",
          x = 416,
          y = 752,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "",
          type = "",
          shape = "rectangle",
          x = 320,
          y = 768,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 19,
          name = "",
          type = "",
          shape = "rectangle",
          x = 256,
          y = 752,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 20,
          name = "",
          type = "",
          shape = "rectangle",
          x = 512,
          y = 592,
          width = 32,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["ledge"] = true,
            ["oneway"] = false
          }
        },
        {
          id = 21,
          name = "",
          type = "",
          shape = "rectangle",
          x = 288,
          y = 656,
          width = 64,
          height = 16,
          rotation = 0,
          visible = true,
          properties = {
            ["ledge"] = false,
            ["oneway"] = true
          }
        }
      }
    },
    {
      type = "objectgroup",
      id = 4,
      name = "Slopes",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      draworder = "topdown",
      properties = {},
      objects = {
        {
          id = 13,
          name = "",
          type = "",
          shape = "polyline",
          x = 432,
          y = 752,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 16, y = 0 },
            { x = 48, y = -16 }
          },
          properties = {}
        },
        {
          id = 14,
          name = "",
          type = "",
          shape = "polyline",
          x = 368,
          y = 768,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 16, y = 0 },
            { x = 48, y = -16 }
          },
          properties = {}
        },
        {
          id = 16,
          name = "",
          type = "",
          shape = "polyline",
          x = 288,
          y = 752,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = 16 }
          },
          properties = {}
        },
        {
          id = 17,
          name = "",
          type = "",
          shape = "polyline",
          x = 208,
          y = 784,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 16, y = -16 }
          },
          properties = {}
        },
        {
          id = 18,
          name = "",
          type = "",
          shape = "polyline",
          x = 224,
          y = 768,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polyline = {
            { x = 0, y = 0 },
            { x = 32, y = -16 }
          },
          properties = {}
        }
      }
    }
  }
}
