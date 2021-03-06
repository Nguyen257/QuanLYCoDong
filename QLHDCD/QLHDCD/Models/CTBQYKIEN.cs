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
    
    public partial class CTBQYKIEN
    {
        public CTBQYKIEN()
        {
            THOIGIANBAU = DateTime.Now;
            LUACHON = 0;
        }
        [DisplayName("Mã ý kiến")]
        public int MAYK { get; set; }
        [DisplayName("Mã đại hội")]
        public string MADH { get; set; }
        [DisplayName("Mã người bầu")]
        public int MACD { get; set; }
        [DisplayName("Ý kiến lựa chọn")]
        public Nullable<int> LUACHON { get; set; }
        [DisplayName("Nội dung ý kiến khác")]
        public string NOIDUNGYKKHAC { get; set; }
        [DisplayName("Thời gian bầu")]
        public Nullable<System.DateTime> THOIGIANBAU { get; set; }
        [DisplayName("Số lượng phiếu bầu")]
        public Nullable<int> SLPHIEUBAU { get; set; }
    
        public virtual BANGYKIEN BANGYKIEN { get; set; }
        public virtual CT_DHCD CT_DHCD { get; set; }
    }
}
