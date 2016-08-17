﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace QLHDCD.Models
{
    using System;
    using System.Collections.Generic;
    using System.ComponentModel;
    
    public partial class CODONG
    {
        public CODONG()
        {
            this.QuocTich = "VN";
            this.ChucVu = "CO DONG";
            this.CT_DHCD = new HashSet<CT_DHCD>();
        }

        [DisplayName("Mã cổ đông")]
        public int MACD { get; set; }
        [DisplayName("Họ và tên cổ đông")]
        public string HoTen { get; set; }
        [DisplayName("CMND")]
        public Nullable<int> CMND { get; set; }
        [DisplayName("Ngày cấp")]
        public string NgayCap { get; set; }
        [DisplayName("Nơi cấp")]
        public string NoiCap { get; set; }
        [DisplayName("Địa chỉ")]
        public string DiaChi { get; set; }
        [DisplayName("Quốc tịch")]
        public string QuocTich { get; set; }
        [DisplayName("Chức vụ")]
        public string ChucVu { get; set; }
        [DisplayName("Email")]
        public string Email { get; set; }
        [DisplayName("SĐT")]
        public string SDT { get; set; }
        [DisplayName("Trình độ văn hóa")]
        public string TrinhDoVanHoa { get; set; }
        [DisplayName("Trình độ chuyên môn")]
        public string TrinhDoChuyenMon { get; set; }
        [DisplayName("Ảnh cá nhân")]
        public string ANHCD { get; set; }
    
        public virtual ICollection<CT_DHCD> CT_DHCD { get; set; }
    }
}