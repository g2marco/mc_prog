{
    "targets": [{
        "target_name": "pic_programmer",
        "include_dirs": [
            "src",
            "<!(node -e \"require ('nan')\")"
        ],
        "sources": [
            "src/index.cc",
            "src/PicProgrammer.cc"
        ]
    }]
}